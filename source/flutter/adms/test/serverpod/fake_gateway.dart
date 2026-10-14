import 'dart:async';
import 'package:adms_client/adms_client.dart';
import 'package:adms/features/serverpod/dispatch_controller.dart';

DispatchSnapshot exampleSnapshot({
  int revision = 0,
  bool withIncident = false,
}) => DispatchSnapshot(
  revision: revision,
  incidents: withIncident
      ? [
          DispatchIncident(
            id: 11,
            workspaceId: 1,
            description: 'Road collision needs assistance',
            address: 'Near Manila City Hall',
            latitude: 14.5998,
            longitude: 120.985,
            severity: 'urgent',
            status: 'pending',
            createdAt: DateTime.utc(2026, 10, 14),
            updatedAt: DateTime.utc(2026, 10, 14),
          ),
        ]
      : [],
  units: [
    for (var n = 1; n <= 3; n++)
      DispatchUnit(
        id: n,
        workspaceId: 1,
        callSign: 'MEDIC 0$n',
        crew: 'Demo crew',
        latitude: 14.5995,
        longitude: 120.9842,
        status: 'available',
      ),
  ],
  events: [],
  serverTime: DateTime.utc(2026, 10, 14),
);

class FakeGateway extends DispatchGateway {
  DispatchSnapshot current = exampleSnapshot();
  final updates = StreamController<DispatchSnapshot>.broadcast();
  Object? failure;
  int writes = 0;
  Completer<DispatchSnapshot>? pending;
  @override
  Future<DemoAccess> startDemo() async {
    if (failure != null) throw failure!;
    return DemoAccess(
      token: 'demo-token',
      expiresAt: DateTime.utc(2026, 10, 15),
    );
  }

  @override
  Future<DispatchSnapshot> snapshot(String token) async {
    if (failure != null) throw failure!;
    return current;
  }

  @override
  Stream<DispatchSnapshot> watch(String token) => updates.stream;
  @override
  Future<DispatchSnapshot> report(
    String token,
    String description,
    String address,
    double latitude,
    double longitude,
    String severity,
  ) async {
    writes++;
    if (failure != null) throw failure!;
    if (pending != null) return pending!.future;
    current = exampleSnapshot(
      revision: current.revision + 1,
      withIncident: true,
    );
    current.incidents.single.description = description;
    current.incidents.single.address = address;
    return current;
  }

  @override
  Future<DispatchSnapshot> dispatchNearest(String token, int id) async =>
      current;
  @override
  Future<DispatchSnapshot> advance(
    String token,
    int id,
    String expectedStatus,
  ) async => current;
  @override
  Future<DispatchSnapshot> cancel(String token, int id, String reason) async =>
      current;
  @override
  void close() => updates.close();
}
