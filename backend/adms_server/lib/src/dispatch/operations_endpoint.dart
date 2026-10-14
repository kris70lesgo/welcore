import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'access_control.dart';
import 'dispatch_endpoint.dart';

class OperationsEndpoint extends Endpoint {
  static String _text(String value, int min, int max, String label) {
    value = value.trim();
    if (value.length < min || value.length > max) {
      throw DispatchException(message: '$label must be $min–$max characters.');
    }
    return value;
  }

  static void _coordinates(double lat, double lng) {
    if (!lat.isFinite || !lng.isFinite || lat.abs() > 90 || lng.abs() > 180) {
      throw DispatchException(message: 'Enter valid coordinates.');
    }
  }

  Future<DispatchSnapshot> _change(
    Session session,
    String token,
    List<String> roles,
    String action,
    Future<void> Function(WorkspaceAccess, Transaction) work,
  ) async {
    late DispatchSession workspace;
    await session.db.transaction((tx) async {
      final access = await AccessControl.resolve(
        session,
        token,
        transaction: tx,
      );
      access.require(roles);
      workspace = access.workspace;
      await work(access, tx);
      workspace.revision++;
      await DispatchSession.db.updateRow(session, workspace, transaction: tx);
      await DispatchEvent.db.insertRow(
        session,
        DispatchEvent(
          workspaceId: workspace.id!,
          incidentId: 0,
          message: '${access.profile.name} · $action',
          status: 'operations',
          createdAt: DateTime.now().toUtc(),
        ),
        transaction: tx,
      );
    });
    await AccessControl.signal(session, workspace);
    return DispatchEndpoint().snapshot(session, token);
  }

  Future<DispatchSnapshot> saveUnit(
    Session session,
    String token,
    DispatchUnit input,
  ) async {
    final callSign = _text(input.callSign, 2, 24, 'Call sign'),
        crew = _text(input.crew, 2, 100, 'Crew name');
    _coordinates(input.latitude, input.longitude);
    if (!['ALS', 'BLS', 'Rescue', 'MICU'].contains(input.unitType ?? 'ALS')) {
      throw DispatchException(message: 'Choose a valid unit type.');
    }
    return _change(
      session,
      token,
      ['admin', 'dispatcher'],
      'Updated fleet unit $callSign',
      (access, tx) async {
        final other = await DispatchUnit.db.findFirstRow(
          session,
          where: (t) =>
              t.workspaceId.equals(access.workspace.id!) &
              t.callSign.equals(callSign),
          transaction: tx,
        );
        if (other != null && other.id != input.id) {
          throw DispatchException(message: 'Call sign is already in use.');
        }
        final existing = input.id == null
            ? null
            : await DispatchUnit.db.findById(
                session,
                input.id!,
                transaction: tx,
              );
        if (input.id != null &&
            (existing == null || existing.workspaceId != access.workspace.id)) {
          throw DispatchException(message: 'Unit not found.');
        }
        if (existing != null &&
            !['available', 'outOfService'].contains(existing.status)) {
          if (input.status != existing.status ||
              input.active != existing.active) {
            throw DispatchException(
              message:
                  'Finish the assigned response before changing unit availability.',
            );
          }
        } else if (!['available', 'outOfService'].contains(input.status))
          throw DispatchException(
            message: 'Unit status is controlled by the incident lifecycle.',
          );
        final jobs = existing == null
            ? <MaintenanceJob>[]
            : await MaintenanceJob.db.find(
                session,
                where: (t) =>
                    t.workspaceId.equals(access.workspace.id!) &
                    t.unitId.equals(existing.id!) &
                    t.status.equals('inProgress'),
                transaction: tx,
              );
        if (jobs.isNotEmpty && input.status == 'available') {
          throw DispatchException(
            message:
                'Complete maintenance before returning this unit to service.',
          );
        }
        final value = DispatchUnit(
          id: existing?.id,
          workspaceId: access.workspace.id!,
          callSign: callSign,
          crew: crew,
          latitude:
              existing != null &&
                  !['available', 'outOfService'].contains(existing.status)
              ? existing.latitude
              : input.latitude,
          longitude:
              existing != null &&
                  !['available', 'outOfService'].contains(existing.status)
              ? existing.longitude
              : input.longitude,
          status: input.active ? input.status : 'outOfService',
          active: input.active,
          plateNumber: _text(input.plateNumber ?? '', 0, 30, 'Plate number'),
          unitType: input.unitType ?? 'ALS',
          locationUpdatedAt: DateTime.now().toUtc(),
        );
        if (existing == null) {
          await DispatchUnit.db.insertRow(session, value, transaction: tx);
        } else {
          await DispatchUnit.db.updateRow(session, value, transaction: tx);
        }
      },
    );
  }

  Future<DispatchSnapshot> updateLocation(
    Session session,
    String token,
    int unitId,
    double latitude,
    double longitude,
  ) async {
    _coordinates(latitude, longitude);
    return _change(
      session,
      token,
      ['admin', 'dispatcher', 'crew'],
      'Updated unit location',
      (access, tx) async {
        final unit = await DispatchUnit.db.findById(
          session,
          unitId,
          transaction: tx,
        );
        if (unit == null ||
            unit.workspaceId != access.workspace.id ||
            (access.role == 'crew' &&
                access.account?.assignedUnitId != unitId)) {
          throw DispatchException(
            message: 'Unit is not assigned to your account.',
          );
        }
        unit.latitude = latitude;
        unit.longitude = longitude;
        unit.locationUpdatedAt = DateTime.now().toUtc();
        await DispatchUnit.db.updateRow(session, unit, transaction: tx);
      },
    );
  }

  Future<DispatchSnapshot> saveHospital(
    Session session,
    String token,
    Hospital input,
  ) async {
    final name = _text(input.name, 2, 100, 'Hospital name');
    _coordinates(input.latitude, input.longitude);
    return _change(
      session,
      token,
      ['admin', 'dispatcher'],
      'Updated hospital $name',
      (access, tx) async {
        final existing = input.id == null
            ? null
            : await Hospital.db.findById(session, input.id!, transaction: tx);
        if (input.id != null &&
            (existing == null || existing.workspaceId != access.workspace.id)) {
          throw DispatchException(message: 'Hospital not found.');
        }
        final hospital = Hospital(
          id: existing?.id,
          workspaceId: access.workspace.id!,
          name: name,
          address: _text(input.address, 3, 200, 'Address'),
          phone: _text(input.phone, 0, 40, 'Phone'),
          latitude: input.latitude,
          longitude: input.longitude,
          active: input.active,
        );
        if (existing == null) {
          await Hospital.db.insertRow(session, hospital, transaction: tx);
        } else {
          await Hospital.db.updateRow(session, hospital, transaction: tx);
        }
      },
    );
  }

  Future<DispatchSnapshot> setDestination(
    Session session,
    String token,
    int incidentId,
    int hospitalId,
  ) async {
    return _change(
      session,
      token,
      ['admin', 'dispatcher', 'crew'],
      'Selected receiving hospital',
      (access, tx) async {
        final incident = await DispatchIncident.db.findById(
          session,
          incidentId,
          transaction: tx,
        );
        if (incident == null) {
          throw DispatchException(message: 'Incident not found.');
        }
        access.incident(incident);
        if (['resolved', 'cancelled', 'atHospital'].contains(incident.status)) {
          throw DispatchException(
            message: 'This response can no longer change its destination.',
          );
        }
        final hospital = await Hospital.db.findById(
          session,
          hospitalId,
          transaction: tx,
        );
        if (hospital == null ||
            hospital.workspaceId != access.workspace.id ||
            !hospital.active) {
          throw DispatchException(
            message: 'Choose an active receiving hospital.',
          );
        }
        incident.destinationHospitalId = hospital.id;
        incident.destinationHospitalName = hospital.name;
        incident.updatedAt = DateTime.now().toUtc();
        await DispatchIncident.db.updateRow(session, incident, transaction: tx);
        await DispatchEvent.db.insertRow(
          session,
          DispatchEvent(
            workspaceId: access.workspace.id!,
            incidentId: incidentId,
            message: 'Destination · ${hospital.name}',
            status: incident.status,
            createdAt: DateTime.now().toUtc(),
          ),
          transaction: tx,
        );
      },
    );
  }

  Future<DispatchSnapshot> saveCareReport(
    Session session,
    String token,
    CareReport input,
  ) async {
    for (final (value, min, max, label) in [
      (input.age, 0, 130, 'Age'),
      (input.pulse, 0, 300, 'Pulse'),
      (input.systolic, 20, 300, 'Systolic pressure'),
      (input.diastolic, 10, 200, 'Diastolic pressure'),
      (input.oxygenSaturation, 0, 100, 'Oxygen saturation'),
    ]) {
      if (value != null && (value < min || value > max)) {
        throw DispatchException(
          message: '$label is outside the accepted range.',
        );
      }
    }
    if (input.signedOff &&
        (input.patientName.trim().length < 2 ||
            input.condition.trim().length < 3 ||
            input.handedOverTo.trim().length < 2 ||
            input.treatment.trim().length < 2)) {
      throw DispatchException(
        message:
            'Complete patient, condition, treatment, and receiving staff before signing handover.',
      );
    }
    return _change(
      session,
      token,
      ['admin', 'dispatcher', 'crew'],
      'Saved patient care report',
      (access, tx) async {
        final incident = await DispatchIncident.db.findById(
          session,
          input.incidentId,
          transaction: tx,
        );
        if (incident == null) {
          throw DispatchException(message: 'Incident not found.');
        }
        access.incident(incident);
        if (![
          'onScene',
          'transporting',
          'atHospital',
        ].contains(incident.status)) {
          throw DispatchException(
            message:
                'Patient documentation starts on scene and closes at handover.',
          );
        }
        if (input.signedOff && incident.status != 'atHospital') {
          throw DispatchException(
            message: 'Sign handover after arrival at the hospital.',
          );
        }
        final existing = await CareReport.db.findFirstRow(
          session,
          where: (t) => t.incidentId.equals(input.incidentId),
          transaction: tx,
        );
        if (existing?.signedOff == true) {
          throw DispatchException(
            message: 'Signed handover reports are locked.',
          );
        }
        final report = CareReport(
          id: existing?.id,
          workspaceId: access.workspace.id!,
          incidentId: input.incidentId,
          patientName: _text(input.patientName, 0, 100, 'Patient name'),
          age: input.age,
          condition: _text(input.condition, 0, 1000, 'Condition'),
          pulse: input.pulse,
          systolic: input.systolic,
          diastolic: input.diastolic,
          oxygenSaturation: input.oxygenSaturation,
          treatment: _text(input.treatment, 0, 2000, 'Treatment'),
          notes: _text(input.notes, 0, 2000, 'Notes'),
          handedOverTo: _text(input.handedOverTo, 0, 100, 'Receiving staff'),
          signedOff: input.signedOff,
          updatedAt: DateTime.now().toUtc(),
        );
        if (existing == null) {
          await CareReport.db.insertRow(session, report, transaction: tx);
        } else {
          await CareReport.db.updateRow(session, report, transaction: tx);
        }
        await DispatchEvent.db.insertRow(
          session,
          DispatchEvent(
            workspaceId: access.workspace.id!,
            incidentId: incident.id!,
            message: input.signedOff
                ? 'Patient handover signed'
                : 'Patient care report saved',
            status: incident.status,
            createdAt: DateTime.now().toUtc(),
          ),
          transaction: tx,
        );
      },
    );
  }

  Future<DispatchSnapshot> saveMaintenance(
    Session session,
    String token,
    MaintenanceJob input,
  ) async {
    final title = _text(input.title, 3, 100, 'Maintenance title');
    if (!input.cost.isFinite || input.cost < 0 || input.cost > 10000000) {
      throw DispatchException(message: 'Enter a valid maintenance cost.');
    }
    return _change(
      session,
      token,
      ['admin', 'dispatcher'],
      'Updated maintenance: $title',
      (access, tx) async {
        final unit = await DispatchUnit.db.findById(
          session,
          input.unitId,
          transaction: tx,
        );
        if (unit == null || unit.workspaceId != access.workspace.id) {
          throw DispatchException(message: 'Unit not found.');
        }
        final existing = input.id == null
            ? null
            : await MaintenanceJob.db.findById(
                session,
                input.id!,
                transaction: tx,
              );
        if (input.id != null &&
            (existing == null ||
                existing.workspaceId != access.workspace.id ||
                existing.unitId != input.unitId)) {
          throw DispatchException(message: 'Maintenance record not found.');
        }
        final allowed = existing == null
            ? ['scheduled']
            : existing.status == 'scheduled'
            ? ['scheduled', 'inProgress']
            : existing.status == 'inProgress'
            ? ['inProgress', 'completed']
            : <String>[];
        if (!allowed.contains(input.status)) {
          throw DispatchException(
            message: 'Follow scheduled → in progress → completed.',
          );
        }
        if (input.status == 'inProgress') {
          if (!['available', 'outOfService'].contains(unit.status)) {
            throw DispatchException(
              message:
                  'Finish the active response before starting maintenance.',
            );
          }
          unit.status = 'outOfService';
          await DispatchUnit.db.updateRow(session, unit, transaction: tx);
        }
        final job = MaintenanceJob(
          id: existing?.id,
          workspaceId: access.workspace.id!,
          unitId: unit.id!,
          title: title,
          notes: _text(input.notes, 0, 1000, 'Notes'),
          dueAt: input.dueAt.toUtc(),
          cost: input.cost,
          status: input.status,
          updatedAt: DateTime.now().toUtc(),
        );
        if (existing == null) {
          await MaintenanceJob.db.insertRow(session, job, transaction: tx);
        } else {
          await MaintenanceJob.db.updateRow(session, job, transaction: tx);
        }
        if (input.status == 'completed' && unit.active) {
          final other = await MaintenanceJob.db.count(
            session,
            where: (t) =>
                t.unitId.equals(unit.id!) & t.status.equals('inProgress'),
            transaction: tx,
          );
          if (other == 0) {
            unit.status = 'available';
            await DispatchUnit.db.updateRow(session, unit, transaction: tx);
          }
        }
      },
    );
  }

  Future<DispatchSnapshot> settings(
    Session session,
    String token,
    String name,
    bool autoDispatch,
    int responseTargetMinutes,
  ) async {
    name = _text(name, 2, 100, 'Organization name');
    if (responseTargetMinutes < 1 || responseTargetMinutes > 120) {
      throw DispatchException(
        message: 'Response target must be 1–120 minutes.',
      );
    }
    return _change(session, token, ['admin'], 'Updated organization settings', (
      access,
      tx,
    ) async {
      access.workspace.name = name;
      access.workspace.autoDispatch = autoDispatch;
      access.workspace.responseTargetMinutes = responseTargetMinutes;
    });
  }
}
