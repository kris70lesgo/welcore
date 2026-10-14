import 'package:adms/features/serverpod/dispatch_controller.dart';
import 'package:adms/features/serverpod/dispatch_workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'fake_gateway.dart';

void main() {
  late FakeGateway gateway;
  late DispatchController controller;
  setUp(() {
    gateway = FakeGateway();
    controller = DispatchController(gateway: gateway);
  });
  tearDown(() => controller.dispose());
  Future<void> render(WidgetTester tester, {bool mobile = false}) async {
    tester.view.physicalSize = mobile
        ? const Size(390, 844)
        : const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      ServerpodDispatchApp(controller: controller, showMap: false),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('explains the simulation and starts the dispatch desk', (
    tester,
  ) async {
    await render(tester);
    expect(find.text('Start dispatch demo'), findsOneWidget);
    await tester.tap(find.text('Start dispatch demo'));
    await tester.pumpAndSettle();
    expect(find.text('The queue is clear.'), findsOneWidget);
    expect(find.text('MEDIC 01'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('validates intake and creates an example incident', (
    tester,
  ) async {
    await controller.startDemo();
    await render(tester);
    await tester.tap(find.byKey(const Key('report-incident')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Create incident'));
    await tester.pumpAndSettle();
    expect(find.text('Use at least 8 characters.'), findsOneWidget);
    expect(gateway.writes, 0);
    await tester.tap(find.text('Fill example incident'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Create incident'));
    await tester.pumpAndSettle();
    expect(gateway.writes, 1);
    expect(find.text('Dispatch nearest unit'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('fleet and activity navigation work', (tester) async {
    await controller.startDemo();
    await render(tester);
    await tester.tap(find.text('Fleet status'));
    await tester.pumpAndSettle();
    expect(find.text('Ambulance units'), findsOneWidget);
    await tester.tap(find.text('Activity log'));
    await tester.pumpAndSettle();
    expect(find.text('Response timeline'), findsOneWidget);
  });
  testWidgets('mobile dashboard remains usable without overflow', (
    tester,
  ) async {
    await controller.startDemo();
    await render(tester, mobile: true);
    expect(find.text('Manila operations'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.byType(DropdownButtonFormField<int>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fleet').last);
    await tester.pumpAndSettle();
    expect(find.text('Ambulance units'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('backend failure is visible and retry remains available', (
    tester,
  ) async {
    gateway.failure = StateError('offline');
    await controller.startDemo();
    await render(tester);
    expect(find.textContaining('Cannot reach Serverpod'), findsOneWidget);
    expect(find.text('Start dispatch demo'), findsOneWidget);
  });
}
