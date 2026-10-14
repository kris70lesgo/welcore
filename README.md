# ADMS — Serverpod ambulance dispatch application

A complete local Flutter application for an organization to manage incident intake, ambulance responses, crew assignments, receiving hospitals, patient handover, fleet maintenance, and reports. The default application runs entirely on **Serverpod 4.0.4 and PostgreSQL**.

## Run

Requires Flutter/Dart ≥3.12.2, PostgreSQL 18, and Python 3.

```bash
# Terminal 1: API (applies included migrations)
./scripts/run-demo.sh

# Terminal 2: builds and serves the app, including the local map preview proxy
./scripts/run-web.sh
```

Open **http://localhost:8181**.

- **Start dispatch demo** creates an isolated 24-hour simulation.
- **Create organization** creates a persistent organization and administrator. Save the one-time recovery code shown after registration.
- **Sign in** restores an existing account.
- **Join with invitation** enrolls staff/citizens or consumes an account recovery code.

On a clean machine, start the included database with `cd backend/adms_server && docker compose up -d`, then copy `config/passwords.yaml.example` to `config/passwords.yaml`. For an existing PostgreSQL installation, see [setup](docs/SERVERPOD.md). Scripts also recognize the local Flutter SDK installed in `../.tooling/flutter`.

## Complete workflows

| User | Working features |
|---|---|
| Administrator | Organization setup, login, recovery, member invitations and deactivation, crew/unit assignment, all operational features, settings |
| Dispatcher | Report/search incidents, nearest-unit or automatic dispatch, progress/cancellation, fleet, hospitals, maintenance, audit log and analytics |
| Crew | Own assigned responses, manual/device location, receiving hospital, patient care documentation, signed handover and care-report PDF |
| Citizen | Report incidents, track own responses live, cancel an unassigned request; other users' reports and clinical records are excluded |

All mutations are validated on the server. Workspace locking makes assignment and lifecycle changes atomic. WebSocket messages signal revisions; every subscriber re-authorizes and reads a filtered snapshot. Signed handover reports are locked. Maintenance keeps unavailable units out of dispatch.

The interface includes desktop/mobile layouts, role-specific navigation, live notification badges, connection/error/saving/empty states, incident search/history, reload-safe intake drafts, date-filtered analytics, target compliance, and CSV/PDF downloads. Drafts clear on successful submission or sign-out.

## Verify

```bash
./scripts/test.sh

# With the API running:
cd backend/adms_client
dart run tool/smoke.dart
dart run tool/application_smoke.dart
```

Verified: **137 Flutter unit/widget tests, 23 backend unit/integration tests**, release web compilation, multi-client dispatch, citizen stream privacy, signed handover, session revocation, and logout. See [verification results](docs/TEST_RESULTS.md), [UI system](docs/UI_SYSTEM.md), and [demo script](docs/HACKATHON.md).

## Judge test build

The hosted entry build is at **https://welcore.serverpod.space/**, backed by Serverpod Cloud. Its first-project trial is free through 14 November 2026; the Starter plan is $5/month after the trial if the project remains active. The hackathon judging period ends earlier, on 20 October. The site contains only fictional dispatch data.

To run the same app locally with Docker Engine or OrbStack, run `./scripts/build-judge.sh` once for a release web build, then `./scripts/run-judge.sh`. Open **http://localhost:8182** and select **Start dispatch demo**. The compose file keeps PostgreSQL and the API private inside Docker; the web app and API share one URL. Stop it with `docker compose --env-file .local/judge.env -f compose.judge.yaml down`.

The entry's demo needs a publicly reachable site or downloadable build until judging ends, and a public video under two minutes. See the entry copy, build instructions, and source disclosure in [submission notes](docs/SUBMISSION.md).

## Structure

- `backend/adms_server/`: account, dispatch and operations endpoints; private/public models; migrations; tests.
- `backend/adms_client/`: generated client and live smoke tests.
- `source/flutter/adms/lib/features/serverpod/`: full default application UI, controller, account/forms, exports.
- `scripts/`: database/API/web startup, checks, preview proxy and source packaging.

## External services and verified scope

The completed app does not require Firebase credentials. Enrollment/recovery uses private one-time codes; email addresses are login identifiers and are not externally verified. Notifications are in-app. SMTP, SMS, native push, and a live emergency-service connection are not configured. Device location is user initiated; manual location is available. Maps use external OpenStreetMap tiles, with a cache for the local preview. Native release builds were not validated; the hosted web release and responsive UI were validated.

The app is suitable for a hackathon demonstration with fictional records. Public deployment and real operational use require external service configuration and an independent review of deployment/privacy requirements. The hackathon entry has not been submitted.

## Attribution

This extends [Sajed Lopez Mendoza's Apache-licensed ADMS](https://github.com/qppd/ambulance-dispatch-management-system). The original license, attribution and [legacy documentation](docs/LEGACY_README.md) are retained. The new full app replaces the default Firebase workflow with Serverpod; the original Firebase screens remain as reference under the separate legacy entrypoint. Disclose the inherited source and check the event's rules for pre-existing code before claiming eligibility.
