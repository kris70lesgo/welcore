import 'package:adms_server/src/generated/protocol.dart';
import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Complete organization app', (builder, endpoints) {
    late AuthAccess admin;
    late String ownerEmail;
    var sequence = 0;
    setUp(() async {
      ownerEmail = 'owner-${++sequence}@adms.test';
      admin = await endpoints.account.registerOrganization(
        builder,
        'Metro response',
        'Organization owner',
        ownerEmail,
        'correct horse battery staple',
      );
    });
    Future<AuthAccess> member(String role, {String? email, int? unitId}) async {
      final invite = await endpoints.account.invite(
        builder,
        admin.token,
        email ?? '$role@adms.test',
        role,
        unitId,
        false,
      );
      return endpoints.account.acceptInvite(
        builder,
        invite.token,
        'Test $role',
        'strong test password 2026',
      );
    }

    Future<DispatchSnapshot> report(
      String token, {
      String text = 'A fictional incident needs assistance',
    }) => endpoints.dispatch.report(
      builder,
      token,
      text,
      'Manila City Hall',
      14.5998,
      120.985,
      'urgent',
    );
    Future<void> denied(Future<Object?> action) =>
        expectLater(action, throwsA(isA<DispatchException>()));

    test(
      'registration persists a private organization and password is never exposed',
      () async {
        final snapshot = await endpoints.dispatch.snapshot(
          builder,
          admin.token,
        );
        expect(admin.recoveryCode, isNotNull);
        expect(snapshot.config!.isDemo, isFalse);
        expect(snapshot.config!.name, 'Metro response');
        expect(snapshot.viewer!.role, 'admin');
        expect(snapshot.hospitals, hasLength(1));
        final signedIn = await endpoints.account.login(
          builder,
          ownerEmail.toUpperCase(),
          'correct horse battery staple',
        );
        expect(signedIn.profile.id, admin.profile.id);
        await denied(
          endpoints.account.login(builder, ownerEmail, 'wrong password'),
        );
        final session = builder.build();
        final account = await StaffAccount.db.findFirstRow(
          session,
          where: (t) => t.email.equals(ownerEmail),
        );
        expect(account!.passwordHash, isNot('correct horse battery staple'));
        expect(account.passwordSalt, isNotEmpty);
        expect(snapshot.toJson().toString(), isNot(contains('passwordHash')));
        await denied(
          endpoints.account.registerOrganization(
            builder,
            'Other',
            'Other',
            ownerEmail,
            'correct horse battery staple',
          ),
        );
      },
    );
    test(
      'one-time invitations constrain role and citizen sees only own requests',
      () async {
        final citizen = await member('citizen');
        final other = await member('citizen', email: 'other@adms.test');
        await report(citizen.token);
        await report(other.token, text: 'A separate citizen report');
        final own = await endpoints.dispatch.snapshot(builder, citizen.token);
        expect(own.incidents, hasLength(1));
        expect(own.incidents.single.reporterAccountId, citizen.profile.id);
        expect(own.staff, isEmpty);
        expect(own.careReports, isEmpty);
        expect(own.units, isEmpty);
        await denied(
          endpoints.dispatch.dispatchNearest(
            builder,
            citizen.token,
            own.incidents.single.id!,
          ),
        );
        await denied(
          endpoints.operations.settings(
            builder,
            citizen.token,
            'Hacked',
            true,
            10,
          ),
        );
        final otherId = (await endpoints.dispatch.snapshot(
          builder,
          other.token,
        )).incidents.single.id!;
        await denied(
          endpoints.dispatch.cancel(
            builder,
            citizen.token,
            otherId,
            'Access attempt',
          ),
        );
        final invite = await endpoints.account.invite(
          builder,
          admin.token,
          'once@adms.test',
          'dispatcher',
          null,
          false,
        );
        await endpoints.account.acceptInvite(
          builder,
          invite.token,
          'Dispatcher',
          'strong test password 2026',
        );
        await denied(
          endpoints.account.acceptInvite(
            builder,
            invite.token,
            'Dispatcher',
            'strong test password 2026',
          ),
        );
      },
    );
    test('crew can update only its own unit and assigned incidents', () async {
      final fleet = (await endpoints.dispatch.snapshot(
        builder,
        admin.token,
      )).units;
      final crew = await member('crew', unitId: fleet.first.id);
      var snapshot = await report(admin.token);
      final id = snapshot.incidents.first.id!;
      await endpoints.dispatch.dispatchNearest(builder, admin.token, id);
      expect(
        (await endpoints.dispatch.snapshot(builder, crew.token)).incidents,
        hasLength(1),
      );
      await endpoints.dispatch.advance(builder, crew.token, id, 'dispatched');
      await endpoints.operations.updateLocation(
        builder,
        crew.token,
        fleet.first.id!,
        14.600,
        120.986,
      );
      await denied(
        endpoints.operations.updateLocation(
          builder,
          crew.token,
          fleet.last.id!,
          14.600,
          120.986,
        ),
      );
      await denied(
        endpoints.dispatch.report(
          builder,
          crew.token,
          'Not a crew action',
          'Manila',
          14.6,
          120.9,
          'normal',
        ),
      );
      await denied(
        endpoints.account.invite(
          builder,
          crew.token,
          'attack@adms.test',
          'admin',
          null,
          false,
        ),
      );
    });
    test('organization identifiers cannot bypass tenant permissions', () async {
      final other = await endpoints.account.registerOrganization(
        builder,
        'Other organization',
        'Other owner',
        'other-owner@adms.test',
        'other strong password 2026',
      );
      final snapshot = await report(admin.token);
      final unit = snapshot.units.first;
      await denied(
        endpoints.dispatch.dispatchNearest(
          builder,
          other.token,
          snapshot.incidents.first.id!,
        ),
      );
      await denied(endpoints.operations.saveUnit(builder, other.token, unit));
      await denied(
        endpoints.account.updateMember(
          builder,
          other.token,
          admin.profile.id,
          false,
          null,
        ),
      );
      expect(
        (await endpoints.dispatch.snapshot(builder, other.token)).incidents,
        isEmpty,
      );
    });
    test(
      'maintenance prevents dispatch and completion restores availability',
      () async {
        final snapshot = await endpoints.dispatch.snapshot(
          builder,
          admin.token,
        );
        final unit = snapshot.units.first;
        var result = await endpoints.operations.saveMaintenance(
          builder,
          admin.token,
          MaintenanceJob(
            workspaceId: 999,
            unitId: unit.id!,
            title: 'Brake inspection',
            notes: 'Scheduled test work',
            dueAt: DateTime.now().toUtc(),
            cost: 50,
            status: 'scheduled',
            updatedAt: DateTime.now().toUtc(),
          ),
        );
        final job = result.maintenance!.single;
        result = await endpoints.operations.saveMaintenance(
          builder,
          admin.token,
          job.copyWith(status: 'inProgress'),
        );
        expect(
          result.units.firstWhere((u) => u.id == unit.id).status,
          'outOfService',
        );
        result = await report(admin.token);
        result = await endpoints.dispatch.dispatchNearest(
          builder,
          admin.token,
          result.incidents.first.id!,
        );
        expect(result.incidents.first.assignedUnitId, isNot(unit.id));
        await denied(
          endpoints.operations.saveUnit(
            builder,
            admin.token,
            unit.copyWith(status: 'available'),
          ),
        );
        result = await endpoints.operations.saveMaintenance(
          builder,
          admin.token,
          job.copyWith(status: 'completed'),
        );
        expect(
          result.units.firstWhere((u) => u.id == unit.id).status,
          'available',
        );
      },
    );
    test(
      'hospital and signed patient report are required for persistent handover',
      () async {
        var snapshot = await report(admin.token);
        final id = snapshot.incidents.first.id!;
        await endpoints.dispatch.dispatchNearest(builder, admin.token, id);
        await endpoints.dispatch.advance(
          builder,
          admin.token,
          id,
          'dispatched',
        );
        await endpoints.dispatch.advance(builder, admin.token, id, 'enRoute');
        await denied(
          endpoints.dispatch.advance(builder, admin.token, id, 'onScene'),
        );
        snapshot = await endpoints.dispatch.snapshot(builder, admin.token);
        await endpoints.operations.setDestination(
          builder,
          admin.token,
          id,
          snapshot.hospitals!.first.id!,
        );
        await endpoints.dispatch.advance(builder, admin.token, id, 'onScene');
        await endpoints.dispatch.advance(
          builder,
          admin.token,
          id,
          'transporting',
        );
        await denied(
          endpoints.dispatch.advance(builder, admin.token, id, 'atHospital'),
        );
        final care = CareReport(
          workspaceId: 999,
          incidentId: id,
          patientName: 'Fictional patient',
          age: 32,
          condition: 'Stable condition recorded',
          pulse: 82,
          systolic: 120,
          diastolic: 80,
          oxygenSaturation: 98,
          treatment: 'Fictional care documented',
          notes: 'Test only',
          handedOverTo: 'Receiving nurse',
          signedOff: true,
          updatedAt: DateTime.now().toUtc(),
        );
        await endpoints.operations.saveCareReport(builder, admin.token, care);
        await denied(
          endpoints.operations.saveCareReport(
            builder,
            admin.token,
            care.copyWith(notes: 'Alter signed report'),
          ),
        );
        snapshot = await endpoints.dispatch.advance(
          builder,
          admin.token,
          id,
          'atHospital',
        );
        expect(snapshot.incidents.first.status, 'resolved');
        expect(
          snapshot.careReports!.single.workspaceId,
          admin.profile.workspaceId,
        );
      },
    );
    test(
      'invalid care values and cross-incident records are rejected',
      () async {
        final snapshot = await report(admin.token);
        final id = snapshot.incidents.first.id!;
        final care = CareReport(
          workspaceId: 0,
          incidentId: id,
          patientName: 'Test',
          condition: 'Test',
          pulse: 400,
          treatment: 'Test',
          notes: '',
          handedOverTo: 'Nurse',
          signedOff: false,
          updatedAt: DateTime.now().toUtc(),
        );
        await denied(
          endpoints.operations.saveCareReport(builder, admin.token, care),
        );
        await denied(
          endpoints.operations.saveCareReport(
            builder,
            admin.token,
            care.copyWith(pulse: 80),
          ),
        );
        expect(
          (await endpoints.dispatch.snapshot(builder, admin.token)).careReports,
          isEmpty,
        );
      },
    );
    test('automatic dispatch assigns within report creation', () async {
      await endpoints.operations.settings(
        builder,
        admin.token,
        'Metro renamed',
        true,
        8,
      );
      final snapshot = await report(admin.token);
      expect(snapshot.incidents.first.status, 'dispatched');
      expect(
        snapshot.events.where(
          (e) => e.incidentId == snapshot.incidents.first.id,
        ),
        hasLength(2),
      );
      expect(snapshot.config!.responseTargetMinutes, 8);
    });
    test('logout and member deactivation revoke access immediately', () async {
      final dispatcher = await member('dispatcher');
      await endpoints.account.updateMember(
        builder,
        admin.token,
        dispatcher.profile.id,
        false,
        null,
      );
      await denied(endpoints.dispatch.snapshot(builder, dispatcher.token));
      await denied(
        endpoints.account.login(
          builder,
          'dispatcher@adms.test',
          'strong test password 2026',
        ),
      );
      await denied(
        endpoints.account.updateMember(
          builder,
          admin.token,
          admin.profile.id,
          false,
          null,
        ),
      );
      await endpoints.account.logout(builder, admin.token);
      await denied(endpoints.dispatch.snapshot(builder, admin.token));
    });
    test(
      'recovery codes reset password, revoke old sessions and cannot be reused',
      () async {
        final dispatcher = await member('dispatcher');
        final recovery = await endpoints.account.invite(
          builder,
          admin.token,
          'dispatcher@adms.test',
          'dispatcher',
          null,
          true,
        );
        final recovered = await endpoints.account.acceptInvite(
          builder,
          recovery.token,
          'Ignored new name',
          'replacement password 2026',
        );
        expect(recovered.profile.id, dispatcher.profile.id);
        await denied(endpoints.dispatch.snapshot(builder, dispatcher.token));
        await denied(
          endpoints.account.acceptInvite(
            builder,
            recovery.token,
            'Test',
            'replacement password 2026',
          ),
        );
        await endpoints.account.login(
          builder,
          'dispatcher@adms.test',
          'replacement password 2026',
        );
      },
    );
  }, ephemeralDatabase: false);
}
