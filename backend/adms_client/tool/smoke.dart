import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:adms_client/adms_client.dart';

void verify(bool value, String label) {
  if (!value) throw StateError('FAIL: $label');
  print('PASS: $label');
}

Future<void> main() async {
  final url = Platform.environment['SERVERPOD_URL'] ?? 'http://localhost:8080/';
  final client = Client(url);
  final second = Client(url);
  final watcher = Client(url);
  StreamSubscription<DispatchSnapshot>? subscription;
  try {
    final access = await client.dispatch.startDemo();
    final token = access.token;
    final received = <DispatchSnapshot>[];
    final initial = Completer<void>();
    subscription = watcher.dispatch.watch(token).listen((snapshot) {
      received.add(snapshot);
      if (!initial.isCompleted) initial.complete();
    }, onError: (Object e) { if (!initial.isCompleted) initial.completeError(e); });
    await initial.future.timeout(const Duration(seconds: 10));
    verify(received.first.units.length == 3, 'WebSocket streams an initial stored fleet');
    final reported = await client.dispatch.report(token, 'Smoke test: fictional road collision', 'Near Manila City Hall', 14.5998, 120.985, 'urgent');
    final id = reported.incidents.first.id!;
    var current = await client.dispatch.dispatchNearest(token, id);
    verify(current.incidents.first.assignedCallSign == 'MEDIC 01', 'RPC assigns the nearest unit');
    for (final status in ['dispatched', 'enRoute', 'onScene', 'transporting', 'atHospital']) {
      current = await second.dispatch.advance(token, id, status);
    }
    verify(current.incidents.first.status == 'resolved' && current.units.every((u) => u.status == 'available'), 'Two independent clients complete the response and release the unit');
    verify((await client.dispatch.snapshot(token)).events.length == 7, 'Audit history persists on fresh reads');
    await Future<void>.delayed(const Duration(milliseconds: 300));
    verify(received.any((s) => s.incidents.any((i) => i.status == 'resolved')), 'A third client receives the completed response over WebSocket');
    final other = await second.dispatch.startDemo();
    verify((await second.dispatch.snapshot(other.token)).incidents.isEmpty, 'A second visitor has an isolated workspace');
    final ids = <int>[];
    for (var n = 0; n < 4; n++) {
      final result = await client.dispatch.report(token, 'Concurrent fictional incident $n', 'Manila', 14.5998, 120.985, 'normal');
      ids.add(result.incidents.first.id!);
    }
    final results = await Future.wait(ids.map((id) async {
      try { await second.dispatch.dispatchNearest(token, id); return true; }
      on DispatchException { return false; }
    }));
    verify(results.where((r) => r).length == 3, 'Four concurrent assignments claim exactly three units');
    final finalSnapshot = await client.dispatch.snapshot(token);
    final assigned = finalSnapshot.incidents.where((i) => i.status == 'dispatched').map((i) => i.assignedUnitId).toSet();
    verify(assigned.length == 3, 'Concurrent incidents never share the same ambulance');
    print(jsonEncode({'workflow': 'passed', 'streamMessages': received.length, 'lastRevision': finalSnapshot.revision}));
  } finally {
    await subscription?.cancel(); client.close(); second.close(); watcher.close();
  }
}
