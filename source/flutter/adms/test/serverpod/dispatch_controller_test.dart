import 'dart:async';
import 'package:adms_client/adms_client.dart';
import 'package:adms/features/serverpod/dispatch_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fake_gateway.dart';

void main() {
  late FakeGateway gateway;
  late DispatchController controller;
  setUp(() {
    gateway = FakeGateway();
    controller = DispatchController(gateway: gateway);
  });
  tearDown(() => controller.dispose());
  test('starts a workspace and loads actual gateway data', () async {
    await controller.startDemo();
    expect(controller.token, 'demo-token');
    expect(controller.data!.units, hasLength(3));
    expect(controller.online, isTrue);
    expect(controller.loading, isFalse);
  });
  test('restores an existing session without creating another', () async {
    SharedPreferences.setMockInitialValues({
      'adms.serverpod.demoToken': 'saved-token',
    });
    controller.dispose();
    gateway = FakeGateway();
    controller = DispatchController(
      gateway: gateway,
      preferences: await SharedPreferences.getInstance(),
    );
    await controller.restore();
    expect(controller.token, 'saved-token');
    expect(controller.data, isNotNull);
  });
  test('ignores stream snapshots older than the current revision', () async {
    await controller.startDemo();
    gateway.updates.add(exampleSnapshot(revision: 2, withIncident: true));
    await Future<void>.delayed(Duration.zero);
    gateway.updates.add(exampleSnapshot(revision: 1));
    await Future<void>.delayed(Duration.zero);
    expect(controller.data!.revision, 2);
    expect(controller.data!.incidents, hasLength(1));
  });
  test('prevents duplicate writes while an action is pending', () async {
    await controller.startDemo();
    gateway.pending = Completer<DispatchSnapshot>();
    final first = controller.report(
      'Example incident',
      'Manila',
      14,
      120,
      'urgent',
    );
    expect(
      await controller.report('Example incident', 'Manila', 14, 120, 'urgent'),
      isFalse,
    );
    expect(gateway.writes, 1);
    gateway.pending!.complete(exampleSnapshot(revision: 1, withIncident: true));
    expect(await first, isTrue);
    expect(controller.busy, isFalse);
  });
  test(
    'shows backend validation errors without claiming a connection failure',
    () async {
      await controller.startDemo();
      gateway.failure = DispatchException(message: 'No ambulance available.');
      expect(
        await controller.report(
          'Example incident',
          'Manila',
          14,
          120,
          'urgent',
        ),
        isFalse,
      );
      expect(controller.error, 'No ambulance available.');
      expect(controller.online, isTrue);
    },
  );
  test(
    'retains last saved records after a network failure and recovers',
    () async {
      await controller.startDemo();
      gateway.failure = StateError('network');
      await controller.refresh();
      expect(controller.online, isFalse);
      expect(controller.data!.units, hasLength(3));
      gateway.failure = null;
      await controller.refresh();
      expect(controller.online, isTrue);
      expect(controller.error, isNull);
    },
  );
  test(
    'failed initial connection does not silently create fake data',
    () async {
      gateway.failure = StateError('backend down');
      await controller.startDemo();
      expect(controller.data, isNull);
      expect(controller.loading, isFalse);
      expect(controller.error, contains('Cannot reach Serverpod'));
    },
  );
  test('leaving workspace removes its persisted token', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    controller.dispose();
    gateway = FakeGateway();
    controller = DispatchController(gateway: gateway, preferences: preferences);
    await controller.startDemo();
    await controller.leaveDemo();
    expect(controller.data, isNull);
    expect(controller.token, isNull);
    expect(preferences.getString('adms.serverpod.demoToken'), isNull);
  });
  test(
    'an in-flight action cannot restore a workspace after leaving',
    () async {
      await controller.startDemo();
      gateway.pending = Completer<DispatchSnapshot>();
      final action = controller.report(
        'Example incident',
        'Manila',
        14,
        120,
        'urgent',
      );
      await controller.leaveDemo();
      gateway.pending!.complete(
        exampleSnapshot(revision: 1, withIncident: true),
      );
      expect(await action, isFalse);
      expect(controller.token, isNull);
      expect(controller.data, isNull);
    },
  );
  test('revoked sessions clear sensitive snapshots immediately', () async {
    await controller.startDemo();
    gateway.failure = DispatchException(
      message: 'Session expired or revoked. Sign in again.',
    );
    await controller.refresh();
    expect(controller.token, isNull);
    expect(controller.data, isNull);
    expect(controller.online, isFalse);
  });
}
