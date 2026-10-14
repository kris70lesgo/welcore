import 'dart:async';

import 'package:adms_client/adms_client.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DispatchGateway {
  Future<DemoAccess> startDemo();
  Future<DispatchSnapshot> snapshot(String token);
  Stream<DispatchSnapshot> watch(String token);
  Future<DispatchSnapshot> report(
    String token,
    String description,
    String address,
    double latitude,
    double longitude,
    String severity,
  );
  Future<DispatchSnapshot> dispatchNearest(String token, int id);
  Future<DispatchSnapshot> advance(String token, int id, String expectedStatus);
  Future<DispatchSnapshot> cancel(String token, int id, String reason);
  Future<AuthAccess> login(String email, String password) =>
      throw UnimplementedError();
  Future<AuthAccess> registerOrganization(
    String organization,
    String name,
    String email,
    String password,
  ) => throw UnimplementedError();
  Future<AuthAccess> acceptInvite(
    String invite,
    String name,
    String password,
  ) => throw UnimplementedError();
  Future<void> logout(String token) async {}
  Future<InviteAccess> invite(
    String token,
    String email,
    String role,
    int? unitId,
    bool recovery,
  ) => throw UnimplementedError();
  Future<DispatchSnapshot> updateMember(
    String token,
    int id,
    bool active,
    int? unitId,
  ) => throw UnimplementedError();
  Future<DispatchSnapshot> changePassword(
    String token,
    String oldPassword,
    String newPassword,
  ) => throw UnimplementedError();
  Future<DispatchSnapshot> saveUnit(String token, DispatchUnit unit) =>
      throw UnimplementedError();
  Future<DispatchSnapshot> saveHospital(String token, Hospital hospital) =>
      throw UnimplementedError();
  Future<DispatchSnapshot> setDestination(
    String token,
    int incidentId,
    int hospitalId,
  ) => throw UnimplementedError();
  Future<DispatchSnapshot> saveCareReport(String token, CareReport report) =>
      throw UnimplementedError();
  Future<DispatchSnapshot> saveMaintenance(String token, MaintenanceJob job) =>
      throw UnimplementedError();
  Future<DispatchSnapshot> updateLocation(
    String token,
    int unitId,
    double lat,
    double lng,
  ) => throw UnimplementedError();
  Future<DispatchSnapshot> settings(
    String token,
    String name,
    bool autoDispatch,
    int target,
  ) => throw UnimplementedError();
  void close();
}

class ServerpodDispatchGateway implements DispatchGateway {
  ServerpodDispatchGateway(this.client);
  final Client client;
  @override
  Future<DemoAccess> startDemo() => client.dispatch.startDemo();
  @override
  Future<DispatchSnapshot> snapshot(String token) =>
      client.dispatch.snapshot(token);
  @override
  Stream<DispatchSnapshot> watch(String token) => client.dispatch.watch(token);
  @override
  Future<DispatchSnapshot> report(
    String token,
    String description,
    String address,
    double latitude,
    double longitude,
    String severity,
  ) => client.dispatch.report(
    token,
    description,
    address,
    latitude,
    longitude,
    severity,
  );
  @override
  Future<DispatchSnapshot> dispatchNearest(String token, int id) =>
      client.dispatch.dispatchNearest(token, id);
  @override
  Future<DispatchSnapshot> advance(
    String token,
    int id,
    String expectedStatus,
  ) => client.dispatch.advance(token, id, expectedStatus);
  @override
  Future<DispatchSnapshot> cancel(String token, int id, String reason) =>
      client.dispatch.cancel(token, id, reason);
  @override
  Future<AuthAccess> login(String email, String password) =>
      client.account.login(email, password);
  @override
  Future<AuthAccess> registerOrganization(
    String organization,
    String name,
    String email,
    String password,
  ) => client.account.registerOrganization(organization, name, email, password);
  @override
  Future<AuthAccess> acceptInvite(
    String invite,
    String name,
    String password,
  ) => client.account.acceptInvite(invite, name, password);
  @override
  Future<void> logout(String token) => client.account.logout(token);
  @override
  Future<InviteAccess> invite(
    String token,
    String email,
    String role,
    int? unitId,
    bool recovery,
  ) => client.account.invite(token, email, role, unitId, recovery);
  @override
  Future<DispatchSnapshot> updateMember(
    String token,
    int id,
    bool active,
    int? unitId,
  ) async {
    await client.account.updateMember(token, id, active, unitId);
    return snapshot(token);
  }

  @override
  Future<DispatchSnapshot> changePassword(
    String token,
    String oldPassword,
    String newPassword,
  ) async {
    await client.account.changePassword(token, oldPassword, newPassword);
    return snapshot(token);
  }

  @override
  Future<DispatchSnapshot> saveUnit(String token, DispatchUnit unit) =>
      client.operations.saveUnit(token, unit);
  @override
  Future<DispatchSnapshot> saveHospital(String token, Hospital hospital) =>
      client.operations.saveHospital(token, hospital);
  @override
  Future<DispatchSnapshot> setDestination(
    String token,
    int incidentId,
    int hospitalId,
  ) => client.operations.setDestination(token, incidentId, hospitalId);
  @override
  Future<DispatchSnapshot> saveCareReport(String token, CareReport report) =>
      client.operations.saveCareReport(token, report);
  @override
  Future<DispatchSnapshot> saveMaintenance(String token, MaintenanceJob job) =>
      client.operations.saveMaintenance(token, job);
  @override
  Future<DispatchSnapshot> updateLocation(
    String token,
    int unitId,
    double lat,
    double lng,
  ) => client.operations.updateLocation(token, unitId, lat, lng);
  @override
  Future<DispatchSnapshot> settings(
    String token,
    String name,
    bool autoDispatch,
    int target,
  ) => client.operations.settings(token, name, autoDispatch, target);
  @override
  void close() => client.close();
}

class DispatchController extends ChangeNotifier {
  DispatchController({required this.gateway, this.preferences});
  final DispatchGateway gateway;
  final SharedPreferences? preferences;
  static const _storageKey = 'adms.serverpod.demoToken';
  DispatchSnapshot? data;
  String? token;
  String? error;
  String? recoveryCode;
  bool loading = false;
  bool busy = false;
  bool online = false;
  bool live = false;
  bool _disposed = false;
  StreamSubscription<DispatchSnapshot>? _subscription;
  Timer? _reconnect;
  Timer? _poll;
  bool _refreshing = false;

  Future<void> restore() async {
    token = preferences?.getString(_storageKey);
    if (token != null) await connect();
  }

  Future<void> startDemo() async {
    if (loading || busy) return;
    loading = true;
    error = null;
    _notify();
    try {
      final access = await gateway.startDemo();
      if (_disposed) return;
      token = access.token;
      data = null;
      await preferences?.setString(_storageKey, access.token);
      await connect();
    } catch (e) {
      _fail(e);
    } finally {
      loading = false;
      _notify();
    }
  }

  String get role => data?.viewer?.role ?? 'admin';
  bool get canDispatch => ['admin', 'dispatcher'].contains(role);
  bool get canRespond => ['admin', 'dispatcher', 'crew'].contains(role);
  bool get canReport => ['admin', 'dispatcher', 'citizen'].contains(role);
  bool get isDemo => data?.config?.isDemo ?? true;

  Future<bool> login(String email, String password) =>
      _authenticate(() => gateway.login(email, password));
  Future<bool> registerOrganization(
    String organization,
    String name,
    String email,
    String password,
  ) => _authenticate(
    () => gateway.registerOrganization(organization, name, email, password),
  );
  Future<bool> acceptInvite(String invite, String name, String password) =>
      _authenticate(() => gateway.acceptInvite(invite, name, password));
  Future<bool> _authenticate(Future<AuthAccess> Function() action) async {
    if (loading || busy || _disposed) return false;
    loading = true;
    error = null;
    _notify();
    try {
      final access = await action();
      if (_disposed) return false;
      token = access.token;
      recoveryCode = access.recoveryCode;
      data = null;
      await preferences?.setString(_storageKey, access.token);
      await connect();
      return data != null;
    } catch (e) {
      _fail(e);
      return false;
    } finally {
      loading = false;
      _notify();
    }
  }

  Future<InviteAccess?> invite(
    String email,
    String role,
    int? unitId,
    bool recovery,
  ) async {
    if (busy || token == null) return null;
    busy = true;
    error = null;
    _notify();
    try {
      return await gateway.invite(token!, email, role, unitId, recovery);
    } catch (e) {
      _fail(e);
      return null;
    } finally {
      busy = false;
      _notify();
    }
  }

  Future<bool> updateMember(int id, bool active, int? unitId) =>
      _run((t) => gateway.updateMember(t, id, active, unitId));
  Future<bool> changePassword(String oldPassword, String newPassword) =>
      _run((t) => gateway.changePassword(t, oldPassword, newPassword));
  Future<bool> saveUnit(DispatchUnit unit) =>
      _run((t) => gateway.saveUnit(t, unit));
  Future<bool> saveHospital(Hospital hospital) =>
      _run((t) => gateway.saveHospital(t, hospital));
  Future<bool> setDestination(int incidentId, int hospitalId) =>
      _run((t) => gateway.setDestination(t, incidentId, hospitalId));
  Future<bool> saveCareReport(CareReport report) =>
      _run((t) => gateway.saveCareReport(t, report));
  Future<bool> saveMaintenance(MaintenanceJob job) =>
      _run((t) => gateway.saveMaintenance(t, job));
  Future<bool> updateLocation(int unitId, double lat, double lng) =>
      _run((t) => gateway.updateLocation(t, unitId, lat, lng));
  Future<bool> settings(String name, bool autoDispatch, int target) =>
      _run((t) => gateway.settings(t, name, autoDispatch, target));

  Future<void> connect() async {
    final current = token;
    if (current == null || _disposed) return;
    loading = data == null;
    error = null;
    _notify();
    await _subscription?.cancel();
    _reconnect?.cancel();
    _poll?.cancel();
    live = false;
    try {
      final snapshot = await gateway.snapshot(current);
      if (_disposed || token != current) return;
      _receive(snapshot);
      _watch(current);
      // Reconcile missed messages and recover when WebSocket access is blocked.
      _poll = Timer.periodic(const Duration(seconds: 15), (_) => refresh());
    } catch (e) {
      _fail(e);
    } finally {
      loading = false;
      _notify();
    }
  }

  void _watch(String current) {
    if (_disposed || token != current) return;
    _subscription = gateway
        .watch(current)
        .listen(
          (snapshot) {
            if (_disposed || token != current) return;
            live = true;
            _receive(snapshot);
          },
          onError: (Object e) {
            if (e is DispatchException) _fail(e);
            live = false;
            _notify();
            _scheduleReconnect(current);
          },
          onDone: () {
            live = false;
            _notify();
            _scheduleReconnect(current);
          },
          cancelOnError: true,
        );
  }

  void _scheduleReconnect(String current) {
    if (_disposed || token != current) return;
    _reconnect?.cancel();
    _reconnect = Timer(const Duration(seconds: 5), () => _watch(current));
  }

  Future<void> refresh() async {
    if (_refreshing || _disposed || token == null) return;
    _refreshing = true;
    final current = token!;
    try {
      final snapshot = await gateway.snapshot(current);
      if (token == current) _receive(snapshot);
    } catch (e) {
      if (token == current) _fail(e);
    } finally {
      _refreshing = false;
    }
  }

  Future<bool> report(
    String description,
    String address,
    double latitude,
    double longitude,
    String severity,
  ) => _run(
    (t) =>
        gateway.report(t, description, address, latitude, longitude, severity),
  );
  Future<bool> dispatchNearest(int id) =>
      _run((t) => gateway.dispatchNearest(t, id));
  Future<bool> advance(DispatchIncident incident) =>
      _run((t) => gateway.advance(t, incident.id!, incident.status));
  Future<bool> cancel(int id, String reason) =>
      _run((t) => gateway.cancel(t, id, reason));

  Future<bool> _run(Future<DispatchSnapshot> Function(String) operation) async {
    if (token == null || busy || _disposed) return false;
    final current = token!;
    busy = true;
    error = null;
    _notify();
    try {
      final snapshot = await operation(current);
      if (_disposed || token != current) return false;
      _receive(snapshot);
      return true;
    } catch (e) {
      if (token == current) _fail(e, mutation: true);
      return false;
    } finally {
      busy = false;
      _notify();
    }
  }

  void _receive(DispatchSnapshot snapshot) {
    if (_disposed) return;
    // A late HTTP response or stream event must never reverse newer state.
    if (data == null || snapshot.revision >= data!.revision) data = snapshot;
    online = true;
    error = null;
    _notify();
  }

  void _fail(Object exception, {bool mutation = false}) {
    if (_disposed) return;
    if (exception is DispatchException) {
      error = exception.message;
      if (exception.message.contains('Session expired or revoked') ||
          exception.message.contains('Invalid session')) {
        token = null;
        data = null;
        online = false;
        live = false;
        _subscription?.cancel();
        _reconnect?.cancel();
        _poll?.cancel();
        preferences?.remove(_storageKey);
      }
    } else {
      online = false;
      error = mutation
          ? 'Connection interrupted. Refresh before retrying; the action may have reached the server.'
          : 'Cannot reach Serverpod. Check that the backend is running, then retry.';
    }
    _notify();
  }

  void clearError() {
    error = null;
    _notify();
  }

  Future<void> leaveDemo() async {
    final draftKey =
        'adms.intake.${data?.viewer?.workspaceId ?? 0}.${data?.viewer?.id ?? token}';
    await preferences?.remove(draftKey);
    final previous = token;
    final revoke = previous != null && !isDemo;
    token = null;
    await _subscription?.cancel();
    _subscription = null;
    _reconnect?.cancel();
    _poll?.cancel();
    token = null;
    data = null;
    error = null;
    online = false;
    live = false;
    await preferences?.remove(_storageKey);
    _notify();
    if (revoke) {
      try {
        await gateway.logout(previous);
      } catch (_) {
        /* Local session is already cleared; server session expires in 12h. */
      }
    }
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _subscription?.cancel();
    _reconnect?.cancel();
    _poll?.cancel();
    gateway.close();
    super.dispose();
  }
}
