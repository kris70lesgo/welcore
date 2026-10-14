import 'package:adms_server/src/dispatch/dispatch_endpoint.dart';
import 'package:adms_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  group('Haversine ranking', () {
    test(
      'same position has zero distance',
      () => expect(DispatchEndpoint.distanceKm(14.6, 121, 14.6, 121), 0),
    );
    test(
      'one degree at equator is about 111 km',
      () => expect(
        DispatchEndpoint.distanceKm(0, 0, 0, 1),
        closeTo(111.195, .01),
      ),
    );
    test(
      'antipodes remain finite',
      () => expect(
        DispatchEndpoint.distanceKm(0, 0, 0, 180),
        closeTo(20015.1, 1),
      ),
    );
  });

  withServerpod('Dispatch workflow', (sessionBuilder, endpoints) {
    late String token;
    setUp(() async {
      token = (await endpoints.dispatch.startDemo(sessionBuilder)).token;
    });
    Future<DispatchSnapshot> report({
      String description = 'Road collision needs assistance',
      double latitude = 14.5998,
      double longitude = 120.9850,
      String severity = 'urgent',
    }) => endpoints.dispatch.report(
      sessionBuilder,
      token,
      description,
      'Near Manila City Hall',
      latitude,
      longitude,
      severity,
    );

    test('seeds a private fleet and persists a reported incident', () async {
      final empty = await endpoints.dispatch.snapshot(sessionBuilder, token);
      expect(empty.units, hasLength(3));
      expect(empty.incidents, isEmpty);
      final reported = await report();
      expect(reported.incidents.single.status, 'pending');
      expect(reported.events.single.status, 'pending');
      final reloaded = await endpoints.dispatch.snapshot(sessionBuilder, token);
      expect(reloaded.incidents.single.id, reported.incidents.single.id);
      expect(reloaded.revision, 1);
    });

    test('assigns the nearest available ambulance', () async {
      final pending = await report();
      final assigned = await endpoints.dispatch.dispatchNearest(
        sessionBuilder,
        token,
        pending.incidents.single.id!,
      );
      expect(assigned.incidents.single.assignedCallSign, 'MEDIC 01');
      expect(assigned.incidents.single.dispatchDistanceKm, lessThan(.2));
      expect(
        assigned.units.where((u) => u.status == 'available'),
        hasLength(2),
      );
      expect(assigned.events.first.status, 'dispatched');
    });

    test(
      'completes the whole lifecycle and returns the unit to availability',
      () async {
        final pending = await report();
        final id = pending.incidents.single.id!;
        var result = await endpoints.dispatch.dispatchNearest(
          sessionBuilder,
          token,
          id,
        );
        for (final status in [
          'dispatched',
          'enRoute',
          'onScene',
          'transporting',
          'atHospital',
        ]) {
          result = await endpoints.dispatch.advance(
            sessionBuilder,
            token,
            id,
            status,
          );
        }
        expect(result.incidents.single.status, 'resolved');
        expect(result.incidents.single.onSceneAt, isNotNull);
        expect(result.incidents.single.resolvedAt, isNotNull);
        expect(result.units.every((u) => u.status == 'available'), isTrue);
        expect(result.events, hasLength(7));
        expect(result.revision, 7);
        await expectLater(
          endpoints.dispatch.advance(sessionBuilder, token, id, 'resolved'),
          throwsA(isA<DispatchException>()),
        );
      },
    );

    test('does not dispatch an incident twice', () async {
      final pending = await report();
      final id = pending.incidents.single.id!;
      await endpoints.dispatch.dispatchNearest(sessionBuilder, token, id);
      await expectLater(
        endpoints.dispatch.dispatchNearest(sessionBuilder, token, id),
        throwsA(isA<DispatchException>()),
      );
      final result = await endpoints.dispatch.snapshot(sessionBuilder, token);
      expect(result.units.where((u) => u.status == 'available'), hasLength(2));
      expect(result.events, hasLength(2));
    });

    test('requires the current status and rejects a skipped stage', () async {
      final pending = await report();
      final id = pending.incidents.single.id!;
      await expectLater(
        endpoints.dispatch.advance(sessionBuilder, token, id, 'pending'),
        throwsA(isA<DispatchException>()),
      );
      await endpoints.dispatch.dispatchNearest(sessionBuilder, token, id);
      await expectLater(
        endpoints.dispatch.advance(sessionBuilder, token, id, 'onScene'),
        throwsA(isA<DispatchException>()),
      );
      expect(
        (await endpoints.dispatch.snapshot(
          sessionBuilder,
          token,
        )).incidents.single.status,
        'dispatched',
      );
    });

    test(
      'rejects invalid descriptions, coordinates and priorities without writes',
      () async {
        for (final operation in [
          () => report(description: 'short'),
          () => report(latitude: 91),
          () => report(longitude: -181),
          () => report(severity: 'invented'),
        ]) {
          await expectLater(operation(), throwsA(isA<DispatchException>()));
        }
        expect(
          (await endpoints.dispatch.snapshot(sessionBuilder, token)).incidents,
          isEmpty,
        );
      },
    );

    test('isolates snapshots and writes between demo visitors', () async {
      final pending = await report();
      final other = (await endpoints.dispatch.startDemo(sessionBuilder)).token;
      expect(
        (await endpoints.dispatch.snapshot(sessionBuilder, other)).incidents,
        isEmpty,
      );
      await expectLater(
        endpoints.dispatch.dispatchNearest(
          sessionBuilder,
          other,
          pending.incidents.single.id!,
        ),
        throwsA(isA<DispatchException>()),
      );
      await expectLater(
        endpoints.dispatch.cancel(
          sessionBuilder,
          other,
          pending.incidents.single.id!,
          'Invalid access',
        ),
        throwsA(isA<DispatchException>()),
      );
      expect(
        (await endpoints.dispatch.snapshot(
          sessionBuilder,
          token,
        )).incidents.single.status,
        'pending',
      );
    });

    test('rejects invalid and expired demo tokens', () async {
      await expectLater(
        endpoints.dispatch.snapshot(sessionBuilder, 'not-a-token'),
        throwsA(isA<DispatchException>()),
      );
      await expectLater(
        endpoints.dispatch.snapshot(sessionBuilder, 'x' * 72),
        throwsA(isA<DispatchException>()),
      );
      final session = sessionBuilder.build();
      final row = (await DispatchSession.db.find(session)).first;
      row.expiresAt = DateTime.now().toUtc().subtract(
        const Duration(seconds: 1),
      );
      await DispatchSession.db.updateRow(session, row);
      await expectLater(
        endpoints.dispatch.snapshot(sessionBuilder, token),
        throwsA(isA<DispatchException>()),
      );
    });

    test('keeps the fourth incident pending when all units are busy', () async {
      for (var n = 0; n < 3; n++) {
        final result = await report(
          description: 'Incident number $n needs assistance',
        );
        await endpoints.dispatch.dispatchNearest(
          sessionBuilder,
          token,
          result.incidents.first.id!,
        );
      }
      final result = await report();
      final id = result.incidents.first.id!;
      await expectLater(
        endpoints.dispatch.dispatchNearest(sessionBuilder, token, id),
        throwsA(isA<DispatchException>()),
      );
      final latest = await endpoints.dispatch.snapshot(sessionBuilder, token);
      expect(latest.incidents.first.status, 'pending');
      expect(
        latest.incidents
            .where((i) => i.assignedUnitId != null)
            .map((i) => i.assignedUnitId)
            .toSet(),
        hasLength(3),
      );
    });

    test(
      'cancellation releases the assigned unit and records its reason',
      () async {
        final pending = await report();
        final id = pending.incidents.single.id!;
        await endpoints.dispatch.dispatchNearest(sessionBuilder, token, id);
        await expectLater(
          endpoints.dispatch.cancel(sessionBuilder, token, id, ''),
          throwsA(isA<DispatchException>()),
        );
        final result = await endpoints.dispatch.cancel(
          sessionBuilder,
          token,
          id,
          'Duplicate report',
        );
        expect(result.incidents.single.status, 'cancelled');
        expect(result.units.every((u) => u.status == 'available'), isTrue);
        expect(result.events.first.message, contains('Duplicate report'));
        await expectLater(
          endpoints.dispatch.cancel(sessionBuilder, token, id, 'Again'),
          throwsA(isA<DispatchException>()),
        );
      },
    );
  }, ephemeralDatabase: false);
}
