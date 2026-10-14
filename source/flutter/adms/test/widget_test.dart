import 'package:adms/features/serverpod/dispatch_controller.dart';
import 'package:adms/features/serverpod/dispatch_workspace.dart';
import 'package:flutter_test/flutter_test.dart';
import 'serverpod/fake_gateway.dart';

void main() {
  testWidgets('Serverpod app renders the demo entrypoint', (tester) async {
    final controller = DispatchController(gateway: FakeGateway());
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      ServerpodDispatchApp(controller: controller, showMap: false),
    );
    expect(find.text('Start dispatch demo'), findsOneWidget);
    expect(find.text('Welcore'), findsOneWidget);
  });
}
