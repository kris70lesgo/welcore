import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'access_control.dart';
import 'account_endpoint.dart';

/// Server-authoritative dispatch workflow. Tokens grant access only to one
/// isolated, fictional workspace; no personal or real emergency data is stored.
class DispatchEndpoint extends Endpoint {
  static const _active = [
    'pending',
    'dispatched',
    'enRoute',
    'onScene',
    'transporting',
    'atHospital',
  ];
  static const _next = {
    'dispatched': 'enRoute',
    'enRoute': 'onScene',
    'onScene': 'transporting',
    'transporting': 'atHospital',
    'atHospital': 'resolved',
  };

  Future<DemoAccess> startDemo(Session session) async {
    final token = '${const Uuid().v4()}${const Uuid().v4()}';
    final expires = DateTime.now().toUtc().add(const Duration(hours: 24));
    await session.db.transaction((tx) async {
      final workspace = await DispatchSession.db.insertRow(
        session,
        DispatchSession(
          tokenHash: _hash(token),
          expiresAt: expires,
          revision: 0,
        ),
        transaction: tx,
      );
      await AccountEndpoint.seedWorkspace(session, workspace.id!, tx);
    });
    return DemoAccess(token: token, expiresAt: expires);
  }

  Future<DispatchSnapshot> snapshot(Session session, String token) async {
    return session.db.transaction((tx) async {
      final access = await AccessControl.resolve(
        session,
        token,
        transaction: tx,
      );
      return _snapshot(session, access, tx);
    });
  }

  Stream<DispatchSnapshot> watch(Session session, String token) async* {
    final access = await AccessControl.resolve(session, token);
    final updates = session.messages.createStream<DispatchSnapshot>(
      _channel(access.workspace.id!),
    );
    yield await snapshot(session, token);
    await for (final _ in updates) {
      yield await snapshot(session, token);
    }
  }

  Future<DispatchSnapshot> report(
    Session session,
    String token,
    String description,
    String address,
    double latitude,
    double longitude,
    String severity,
  ) async {
    description = description.trim();
    address = address.trim();
    if (description.length < 8 || description.length > 1000) {
      throw DispatchException(
        message: 'Describe the incident in 8–1000 characters.',
      );
    }
    if (address.length < 3 || address.length > 200) {
      throw DispatchException(message: 'Enter a location in 3–200 characters.');
    }
    if (!latitude.isFinite ||
        !longitude.isFinite ||
        latitude.abs() > 90 ||
        longitude.abs() > 180) {
      throw DispatchException(message: 'Enter valid latitude and longitude.');
    }
    if (!['critical', 'urgent', 'normal'].contains(severity)) {
      throw DispatchException(message: 'Choose a valid incident priority.');
    }
    return _mutate(session, token, (access, tx) async {
      final workspace = access.workspace;
      access.require(['admin', 'dispatcher', 'citizen']);
      final count = await DispatchIncident.db.count(
        session,
        where: (t) =>
            t.workspaceId.equals(workspace.id!) &
            t.status.inSet(_active.toSet()),
        transaction: tx,
      );
      if (count >= 30) {
        throw DispatchException(
          message: 'Resolve an incident before adding more.',
        );
      }
      final now = DateTime.now().toUtc();
      final incident = await DispatchIncident.db.insertRow(
        session,
        DispatchIncident(
          workspaceId: workspace.id!,
          reporterAccountId: access.accountId,
          description: description,
          address: address,
          latitude: latitude,
          longitude: longitude,
          severity: severity,
          status: 'pending',
          createdAt: now,
          updatedAt: now,
        ),
        transaction: tx,
      );
      await _event(
        session,
        incident,
        'Incident reported · awaiting dispatch',
        tx,
      );
      if (workspace.autoDispatch) {
        await _assign(session, workspace, incident, tx, optional: true);
      }
    });
  }

  Future<DispatchSnapshot> dispatchNearest(
    Session session,
    String token,
    int incidentId,
  ) async {
    return _mutate(session, token, (access, tx) async {
      final workspace = access.workspace;
      access.require(['admin', 'dispatcher']);
      final incident = await _incident(session, workspace, incidentId, tx);
      access.incident(incident);
      if (incident.status != 'pending') {
        throw DispatchException(
          message: 'This incident has already been dispatched or closed.',
        );
      }
      await _assign(session, workspace, incident, tx);
    });
  }

  Future<void> _assign(
    Session session,
    DispatchSession workspace,
    DispatchIncident incident,
    Transaction tx, {
    bool optional = false,
  }) async {
    final units = await DispatchUnit.db.find(
      session,
      where: (t) =>
          t.workspaceId.equals(workspace.id!) &
          t.status.equals('available') &
          t.active.equals(true),
      transaction: tx,
    );
    if (units.isEmpty) {
      if (optional) return;
      throw DispatchException(
        message: 'No ambulance available. Finish an active response first.',
      );
    }
    units.sort((a, b) {
      final comparison =
          distanceKm(
            incident.latitude,
            incident.longitude,
            a.latitude,
            a.longitude,
          ).compareTo(
            distanceKm(
              incident.latitude,
              incident.longitude,
              b.latitude,
              b.longitude,
            ),
          );
      return comparison != 0 ? comparison : a.id!.compareTo(b.id!);
    });
    final unit = units.first;
    incident.status = 'dispatched';
    incident.assignedUnitId = unit.id;
    incident.assignedCallSign = unit.callSign;
    incident.dispatchDistanceKm = distanceKm(
      incident.latitude,
      incident.longitude,
      unit.latitude,
      unit.longitude,
    );
    incident.dispatchedAt = DateTime.now().toUtc();
    incident.updatedAt = incident.dispatchedAt!;
    unit.status = 'dispatched';
    await DispatchUnit.db.updateRow(session, unit, transaction: tx);
    await DispatchIncident.db.updateRow(session, incident, transaction: tx);
    await _event(
      session,
      incident,
      '${unit.callSign} assigned · ${incident.dispatchDistanceKm!.toStringAsFixed(2)} km straight-line distance',
      tx,
    );
  }

  Future<DispatchSnapshot> advance(
    Session session,
    String token,
    int incidentId,
    String expectedStatus,
  ) async {
    return _mutate(session, token, (access, tx) async {
      final workspace = access.workspace;
      access.require(['admin', 'dispatcher', 'crew']);
      final incident = await _incident(session, workspace, incidentId, tx);
      access.incident(incident);
      if (incident.status != expectedStatus) {
        throw DispatchException(
          message:
              'Incident changed in another window. Review its latest status.',
        );
      }
      final next = _next[incident.status];
      if (next == null) {
        throw DispatchException(message: 'This incident cannot advance.');
      }
      final unit = await DispatchUnit.db.findById(
        session,
        incident.assignedUnitId!,
        transaction: tx,
      );
      if (unit == null || unit.workspaceId != workspace.id) {
        throw DispatchException(message: 'Assigned ambulance is unavailable.');
      }
      if (!workspace.isDemo &&
          next == 'transporting' &&
          incident.destinationHospitalId == null) {
        throw DispatchException(
          message: 'Select a receiving hospital before transport.',
        );
      }
      if (!workspace.isDemo && next == 'resolved') {
        final report = await CareReport.db.findFirstRow(
          session,
          where: (t) => t.incidentId.equals(incident.id!),
          transaction: tx,
        );
        if (report == null ||
            !report.signedOff ||
            report.handedOverTo.trim().isEmpty) {
          throw DispatchException(
            message: 'Complete and sign the patient handover report first.',
          );
        }
      }
      final now = DateTime.now().toUtc();
      incident.status = next;
      incident.updatedAt = now;
      if (next == 'onScene') {
        incident.onSceneAt = now;
        unit.latitude = incident.latitude;
        unit.longitude = incident.longitude;
      }
      if (next == 'resolved') incident.resolvedAt = now;
      unit.status = next == 'resolved' ? 'available' : next;
      await DispatchIncident.db.updateRow(session, incident, transaction: tx);
      await DispatchUnit.db.updateRow(session, unit, transaction: tx);
      await _event(session, incident, '${unit.callSign} · ${_label(next)}', tx);
    });
  }

  Future<DispatchSnapshot> cancel(
    Session session,
    String token,
    int incidentId,
    String reason,
  ) async {
    reason = reason.trim();
    if (reason.length < 3 || reason.length > 200) {
      throw DispatchException(
        message: 'Enter a cancellation reason in 3–200 characters.',
      );
    }
    return _mutate(session, token, (access, tx) async {
      final workspace = access.workspace;
      access.require(['admin', 'dispatcher', 'citizen']);
      final incident = await _incident(session, workspace, incidentId, tx);
      access.incident(incident);
      if (access.role == 'citizen' && incident.status != 'pending') {
        throw DispatchException(
          message: 'Contact the dispatcher to cancel an assigned response.',
        );
      }
      if (!_active.contains(incident.status)) {
        throw DispatchException(message: 'Incident is already closed.');
      }
      if (incident.assignedUnitId != null) {
        final unit = await DispatchUnit.db.findById(
          session,
          incident.assignedUnitId!,
          transaction: tx,
        );
        if (unit != null && unit.workspaceId == workspace.id) {
          unit.status = 'available';
          await DispatchUnit.db.updateRow(session, unit, transaction: tx);
        }
      }
      incident.status = 'cancelled';
      incident.updatedAt = DateTime.now().toUtc();
      await DispatchIncident.db.updateRow(session, incident, transaction: tx);
      await _event(session, incident, 'Cancelled · $reason', tx);
    });
  }

  Future<DispatchSnapshot> _mutate(
    Session session,
    String token,
    Future<void> Function(WorkspaceAccess, Transaction) action,
  ) async {
    late DispatchSession workspace;
    final result = await session.db.transaction((tx) async {
      final access = await AccessControl.resolve(
        session,
        token,
        transaction: tx,
      );
      workspace = access.workspace;
      await action(access, tx);
      workspace.revision++;
      await DispatchSession.db.updateRow(session, workspace, transaction: tx);
      return _snapshot(session, access, tx);
    });
    await AccessControl.signal(session, workspace);
    return result;
  }

  Future<DispatchIncident> _incident(
    Session session,
    DispatchSession workspace,
    int id,
    Transaction tx,
  ) async {
    final incident = await DispatchIncident.db.findFirstRow(
      session,
      where: (t) => t.id.equals(id) & t.workspaceId.equals(workspace.id!),
      transaction: tx,
    );
    if (incident == null) {
      throw DispatchException(message: 'Incident not found in this workspace.');
    }
    return incident;
  }

  Future<DispatchSnapshot> _snapshot(
    Session session,
    WorkspaceAccess access,
    Transaction tx,
  ) async {
    final workspace = access.workspace;
    final allIncidents = await DispatchIncident.db.find(
      session,
      where: (t) => t.workspaceId.equals(workspace.id!),
      orderBy: (t) => t.createdAt.desc(),
      transaction: tx,
    );
    final incidents = allIncidents
        .where(
          (i) => access.role == 'citizen'
              ? i.reporterAccountId == access.accountId
              : access.role == 'crew'
              ? access.account?.assignedUnitId != null &&
                    i.assignedUnitId == access.account?.assignedUnitId
              : true,
        )
        .toList();
    final visibleIds = incidents.map((i) => i.id!).toSet();
    final visibleUnits = incidents
        .map((i) => i.assignedUnitId)
        .whereType<int>()
        .toSet();
    final allUnits = await DispatchUnit.db.find(
      session,
      where: (t) => t.workspaceId.equals(workspace.id!),
      orderBy: (t) => t.callSign,
      transaction: tx,
    );
    final units = allUnits
        .where(
          (u) => access.role == 'citizen'
              ? visibleUnits.contains(u.id)
              : access.role == 'crew'
              ? u.id == access.account?.assignedUnitId
              : true,
        )
        .toList();
    final allEvents = await DispatchEvent.db.find(
      session,
      where: (t) => t.workspaceId.equals(workspace.id!),
      orderBy: (t) => t.id.desc(),
      limit: 100,
      transaction: tx,
    );
    final events = allEvents
        .where(
          (e) =>
              ['admin', 'dispatcher'].contains(access.role) ||
              visibleIds.contains(e.incidentId),
        )
        .toList();
    final hospitals = await Hospital.db.find(
      session,
      where: (t) => t.workspaceId.equals(workspace.id!),
      transaction: tx,
    );
    final care = access.role == 'citizen' || visibleIds.isEmpty
        ? <CareReport>[]
        : await CareReport.db.find(
            session,
            where: (t) =>
                t.workspaceId.equals(workspace.id!) &
                t.incidentId.inSet(visibleIds),
            transaction: tx,
          );
    final maintenance = ['admin', 'dispatcher'].contains(access.role)
        ? await MaintenanceJob.db.find(
            session,
            where: (t) => t.workspaceId.equals(workspace.id!),
            transaction: tx,
          )
        : <MaintenanceJob>[];
    final staff = access.role == 'admin'
        ? (await StaffAccount.db.find(
            session,
            where: (t) => t.workspaceId.equals(workspace.id!),
            transaction: tx,
          )).map(AccessControl.profile).toList()
        : <StaffProfile>[];
    return DispatchSnapshot(
      viewer: access.profile,
      config: WorkspaceConfig(
        name: workspace.name,
        isDemo: workspace.isDemo,
        autoDispatch: workspace.autoDispatch,
        responseTargetMinutes: workspace.responseTargetMinutes,
      ),
      hospitals: hospitals,
      careReports: care,
      maintenance: maintenance,
      staff: staff,
      revision: workspace.revision,
      incidents: incidents,
      units: units,
      events: events,
      serverTime: DateTime.now().toUtc(),
    );
  }

  Future<void> _event(
    Session session,
    DispatchIncident incident,
    String message,
    Transaction tx,
  ) async {
    await DispatchEvent.db.insertRow(
      session,
      DispatchEvent(
        workspaceId: incident.workspaceId,
        incidentId: incident.id!,
        message: message,
        status: incident.status,
        createdAt: DateTime.now().toUtc(),
      ),
      transaction: tx,
    );
  }

  static String _hash(String token) =>
      sha256.convert(utf8.encode(token)).toString();
  static String _channel(int id) => 'dispatch-workspace-$id';
  static String _label(String value) => switch (value) {
    'enRoute' => 'En route to scene',
    'onScene' => 'Arrived at scene',
    'transporting' => 'Transporting patient',
    'atHospital' => 'Hospital handover',
    'resolved' => 'Response completed · unit available',
    _ => value,
  };

  /// Haversine distance, used for ranking, not presented as a road ETA.
  static double distanceKm(double lat1, double lng1, double lat2, double lng2) {
    const radius = 6371.0;
    double radians(double degrees) => degrees * pi / 180;
    final dLat = radians(lat2 - lat1), dLng = radians(lng2 - lng1);
    final a =
        pow(sin(dLat / 2), 2) +
        cos(radians(lat1)) * cos(radians(lat2)) * pow(sin(dLng / 2), 2);
    return 2 * radius * asin(sqrt(a.clamp(0, 1)));
  }
}
