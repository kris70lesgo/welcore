/// Resolves the API base URL for local, same-origin, and Serverpod Cloud builds.
Uri resolveServerpodUrl(Uri appUri, String configuredUrl) {
  const cloudWebSuffix = '.serverpod.space';
  const apiHostSuffix = '.api.serverpod.space';
  const insightsHostSuffix = '.insights.serverpod.space';

  final appHost = appUri.host.toLowerCase();
  final usesCloudWebHost =
      appUri.scheme == 'https' &&
      appHost.endsWith(cloudWebSuffix) &&
      !appHost.endsWith(apiHostSuffix) &&
      !appHost.endsWith(insightsHostSuffix);
  final usesSameOriginApiProxy =
      configuredUrl == '/api' || configuredUrl == '/api/';

  if (usesCloudWebHost && usesSameOriginApiProxy) {
    final projectId = appHost.substring(
      0,
      appHost.length - cloudWebSuffix.length,
    );
    return Uri.https('$projectId.api.serverpod.space', '/');
  }

  return appUri.resolve(configuredUrl);
}
