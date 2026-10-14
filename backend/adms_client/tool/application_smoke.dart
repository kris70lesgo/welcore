import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:adms_client/adms_client.dart';

void check(bool ok, String message) {
  if (!ok) throw StateError(message);
  print('PASS: $message');
}

Future<void> main() async {
  final url = Platform.environment['SERVERPOD_URL'] ?? 'http://localhost:8080/';
  final adminClient = Client(url),
      citizenClient = Client(url),
      crewClient = Client(url);
  StreamSubscription<DispatchSnapshot>? subscription;
  try {
    final suffix = DateTime.now().microsecondsSinceEpoch;
    final password = 'Local-test-only-$suffix';
    final admin = await adminClient.account.registerOrganization(
      'Metro response $suffix',
      'Test administrator',
      'admin-$suffix@adms.test',
      password,
    );
    check(
      admin.recoveryCode != null,
      'organization setup returns a private one-time owner recovery code',
    );
    var snapshot = await adminClient.dispatch.snapshot(admin.token);
    final crewInvite = await adminClient.account.invite(
      admin.token,
      'crew-$suffix@adms.test',
      'crew',
      snapshot.units.first.id,
      false,
    );
    final crew = await crewClient.account.acceptInvite(
      crewInvite.token,
      'Test response crew',
      password,
    );
    final citizenInvite = await adminClient.account.invite(
      admin.token,
      'citizen-$suffix@adms.test',
      'citizen',
      null,
      false,
    );
    final citizen = await citizenClient.account.acceptInvite(
      citizenInvite.token,
      'Test citizen',
      password,
    );
    final frames = <DispatchSnapshot>[];
    final first = Completer<void>();
    final revoked = Completer<void>();
    subscription = citizenClient.dispatch
        .watch(citizen.token)
        .listen(
          (s) {
            frames.add(s);
            if (!first.isCompleted) first.complete();
          },
          onError: (Object e) {
            if (!first.isCompleted)
              first.completeError(e);
            else if (!revoked.isCompleted)
              revoked.complete();
          },
        );
    await first.future.timeout(const Duration(seconds: 10));
    await adminClient.dispatch.report(
      admin.token,
      'Private dispatcher incident',
      'Manila',
      14.62,
      121.0,
      'normal',
    );
    snapshot = await citizenClient.dispatch.report(
      citizen.token,
      'Citizen requests assistance',
      'Near Manila City Hall',
      14.5998,
      120.985,
      'urgent',
    );
    final id = snapshot.incidents.single.id!;
    await adminClient.dispatch.dispatchNearest(admin.token, id);
    check(
      (await crewClient.dispatch.snapshot(crew.token)).incidents.single.id ==
          id,
      'crew sees the assigned response',
    );
    for (final stage in ['dispatched', 'enRoute']) {
      await crewClient.dispatch.advance(crew.token, id, stage);
    }
    await crewClient.operations.setDestination(
      crew.token,
      id,
      snapshot.hospitals!.first.id!,
    );
    await crewClient.dispatch.advance(crew.token, id, 'onScene');
    await crewClient.dispatch.advance(crew.token, id, 'transporting');
    await crewClient.operations.saveCareReport(
      crew.token,
      CareReport(
        workspaceId: 0,
        incidentId: id,
        patientName: 'Fictional patient',
        age: 34,
        condition: 'Recorded stable condition',
        treatment: 'Recorded fictional care',
        notes: 'Smoke test only',
        handedOverTo: 'Receiving staff',
        signedOff: true,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
    snapshot = await crewClient.dispatch.advance(crew.token, id, 'atHospital');
    check(
      snapshot.incidents.single.status == 'resolved',
      'crew completes destination and signed patient handover',
    );
    await Future<void>.delayed(const Duration(milliseconds: 300));
    check(
      frames.every(
        (s) =>
            s.incidents.every(
              (i) => i.reporterAccountId == citizen.profile.id,
            ) &&
            (s.careReports?.isEmpty ?? true) &&
            (s.staff?.isEmpty ?? true),
      ),
      'citizen WebSocket frames never contain other reports, patient care or staff',
    );
    await adminClient.account.updateMember(
      admin.token,
      citizen.profile.id,
      false,
      null,
    );
    await revoked.future.timeout(const Duration(seconds: 10));
    check(true, 'revoking a member terminates its authorized stream');
    final login = await adminClient.account.login(
      'admin-$suffix@adms.test',
      password,
    );
    await adminClient.account.logout(login.token);
    try {
      await adminClient.dispatch.snapshot(login.token);
      throw StateError('logout did not revoke');
    } on DispatchException {
      check(true, 'logout invalidates the server session');
    }
    final file = File('../../.local/application-browser-test.json');
    await file.parent.create(recursive: true);
    await file.writeAsString(
      jsonEncode({
        'email': 'admin-$suffix@adms.test',
        'password': password,
        'workspace': 'Metro response $suffix',
      }),
    );
    print('Full application smoke test passed.');
  } finally {
    await subscription?.cancel();
    adminClient.close();
    citizenClient.close();
    crewClient.close();
  }
}
