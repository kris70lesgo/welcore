import 'dart:io';
import 'package:serverpod/serverpod.dart' show FlutterRoute;
import 'src/generated/serverpod.dart' as generated;
Future<void> run(List<String> args) async {
  final pod = generated.Serverpod(args);
  final webBuild = Directory('web/app');
  if (webBuild.existsSync()) {
    pod.webServer.addRoute(FlutterRoute(webBuild));
  }
  await pod.start();
}
