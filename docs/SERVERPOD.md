# Serverpod setup and architecture

## Existing PostgreSQL setup

The checked-in development and test configs use a dedicated role and two databases at `localhost:5432`. If using an existing local PostgreSQL installation, run these once as a local administrator:

```bash
psql postgres -c "CREATE ROLE adms_dispatch LOGIN PASSWORD 'adms-local-development'"
createdb --owner=adms_dispatch adms_dispatch
createdb --owner=adms_dispatch adms_dispatch_test
```

If these names already exist, keep them; do not recreate or drop existing databases. Copy `backend/adms_server/config/passwords.yaml.example` to `passwords.yaml`. The example password is for local demonstration. Real deployment requires private credentials and environment-specific Serverpod configuration.

On this machine PostgreSQL 18.4 was already running. The dedicated role and the two databases were created, and the checked-in migration was applied to the development database. Docker was not running, so the Docker alternative was prepared but not executed.

## Toolchain

Verified with Flutter 3.47.7, Dart 3.13.5, Serverpod 4.0.4, and PostgreSQL 18.4 on macOS arm64. Dart must be at least 3.12.2 because Serverpod 4 requires it. Do not add local SDK archives to the repository.

Regenerate the protocol after modifying model YAML or endpoint signatures:

```bash
dart pub global activate serverpod_cli 4.0.4
cd backend/adms_server
serverpod generate
serverpod create-migration
```

Generated ORM/client source and migrations are included, so regeneration is not necessary just to run the app. Keep `config/passwords.yaml` private; the example file is intentionally public local setup data.

## Default app startup

`lib/main.dart` initializes the generated Serverpod client, restores a saved simulation token, and starts the Flutter dispatch workspace. It does not initialize Firebase. Set the API address with:

```bash
flutter run -d chrome --dart-define=SERVERPOD_URL=http://localhost:8080/
```

For an Android emulator use `http://10.0.2.2:8080/`; for a physical device use your development host's reachable address. Only the release **web** target was built and browser-tested here. Native platform builds are not verified.

`./scripts/run-web.sh` performs a release web build with `--no-web-resources-cdn`, then serves it on 127.0.0.1:8181. Its local preview server caches requested tiles from the fixed OpenStreetMap host; coordinate validation prevents arbitrary proxy destinations. This handles browsers that block direct external image requests. A regular Flutter run uses OpenStreetMap directly. The tile override is a preview build option, not an application data backend. Set `SERVERPOD_URL` or `ADMS_WEB_PORT` to override these defaults. Open the same origin in a second tab to reuse the locally saved workspace token. A separate browser profile gets its own workspace.

## Data ownership

- `DispatchSession`: server-only SHA-256 token digest, expiry, and monotonic revision.
- `DispatchUnit`: fleet identity, crew, simulated location, and operational status.
- `DispatchIncident`: description, location, priority, stage, assignment, and timestamps.
- `DispatchEvent`: immutable endpoint-created event record for each lifecycle action.
- `DispatchSnapshot`: authoritative public units/incidents/events and revision.

Every state-changing endpoint authorizes the token and locks its workspace row `FOR UPDATE`. It then updates incident and unit rows and inserts an audit event in the same transaction. A successful commit publishes a snapshot on the workspace's Serverpod message channel. The listener is registered before the initial read so startup cannot lose updates. Clients ignore snapshots with older revisions.

The UI retries streaming connections and reconciles the snapshot every 15 seconds. An interrupted write is not automatically retried; the UI asks the user to refresh because the server may already have committed it. Leaving the workspace cancels subscriptions and prevents delayed requests from restoring its data.

## Endpoint contract

| Method | Result |
|---|---|
| `startDemo()` | Random scoped token and 24-hour expiry; seeds three units |
| `snapshot(token)` | Consistent stored state |
| `watch(token)` | Initial snapshot and subsequent WebSocket snapshots |
| `report(token, description, address, latitude, longitude, severity)` | Validated pending incident |
| `dispatchNearest(token, incidentId)` | Closest available unit claimed atomically |
| `advance(token, incidentId, expectedStatus)` | Exactly one legal lifecycle transition |
| `cancel(token, incidentId, reason)` | Closed incident, unit release, audit reason |

## Retained Firebase application

The original UI and services remain in the same Flutter project. To run that entrypoint, configure your own Firebase project with FlutterFire so `lib/firebase_options.dart` exists, then run `flutter run -t lib/main_firebase.dart`. It is excluded from analysis until credentials are generated; the default Serverpod app requires no Firebase credentials. Legacy documentation still describes those features.

## Demo and account modes

Demo workspaces are fictional and expire after 24 hours. Persistent organization accounts support crew location reports, patient documentation, role-based access and signed handover. Incident creation is bounded to 30 active incidents per organization. Maps require the external tile service; intake and dispatch work independently of tiles. No real emergency-service connection is configured.

## Full application additions

The default workspace now includes persistent organizations and four server-enforced roles: admin, dispatcher, crew and citizen. `AccountEndpoint` handles onboarding, login/logout, private one-time enrollment/recovery codes, password changes and member revocation. Passwords use independently salted PBKDF2-HMAC-SHA256 at 600,000 iterations. Stored session/invitation tokens are SHA-256 digests; staff sessions expire after 12 hours. The first administrator receives a one-time recovery code after registration.

`OperationsEndpoint` stores fleet details/location, receiving hospitals, maintenance jobs, structured patient care reports and organization settings. Persistent organizations must select a hospital before transport and sign a complete handover before resolving a response. Demo workspaces retain the simpler walk-through. Signed clinical reports cannot be edited.

Broadcast channels now contain only a revision signal. Every stream subscriber re-authorizes and reads its own snapshot: citizens see their own incidents and no clinical/staff data; crews see assigned incidents and their unit; administrators/dispatchers see their organization's operations. Revocation triggers stream authorization failure, and the Flutter controller clears private state.

External emergency services, verified email delivery, SMS and native push are not configured. Enrollment and recovery are private code flows; administrators must share codes through a trusted channel. This application uses a custom Serverpod account/session implementation rather than an SMTP-dependent identity provider. Authentication attempt limits are per email/code and per server process; distributed deployments should replace them with a shared limiter.

CSV and PDF exports operate on the caller's filtered snapshot. Intake drafts are stored locally for the current account and removed after submission or logout. Never use fictional demo records as an operational ambulance feed.
