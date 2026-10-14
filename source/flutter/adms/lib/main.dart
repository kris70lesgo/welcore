import 'package:adms_client/adms_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/serverpod/dispatch_controller.dart';
import 'features/serverpod/dispatch_workspace.dart';
import 'features/serverpod/serverpod_url.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (const bool.fromEnvironment('LOAD_DOTENV')) {
    await dotenv.load(isOptional: true);
  }
  const serverUrl = String.fromEnvironment(
    'SERVERPOD_URL',
    defaultValue: 'http://localhost:8080/',
  );
  final client = Client(resolveServerpodUrl(Uri.base, serverUrl).toString());
  final preferences = await SharedPreferences.getInstance();
  final controller = DispatchController(
    gateway: ServerpodDispatchGateway(client),
    preferences: preferences,
  );
  runApp(ServerpodDispatchApp(controller: controller));
  await controller.restore();
}
