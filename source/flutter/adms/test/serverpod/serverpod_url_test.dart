import 'package:adms/features/serverpod/serverpod_url.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('routes a Cloud web proxy URL to its paired Cloud API host', () {
    final resolved = resolveServerpodUrl(
      Uri.parse('https://welcore.serverpod.space/'),
      '/api/',
    );

    expect(resolved, Uri.parse('https://welcore.api.serverpod.space/'));
  });

  test('preserves the same-origin proxy for local judge builds', () {
    final resolved = resolveServerpodUrl(
      Uri.parse('http://localhost:8182/'),
      '/api/',
    );

    expect(resolved, Uri.parse('http://localhost:8182/api/'));
  });

  test('preserves an explicitly configured API URL', () {
    final resolved = resolveServerpodUrl(
      Uri.parse('https://welcore.serverpod.space/'),
      'https://api.example.test/',
    );

    expect(resolved, Uri.parse('https://api.example.test/'));
  });
}
