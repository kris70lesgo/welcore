# ADMS Dispatch — hackathon submission

## Description

ADMS Dispatch is a full-stack ambulance-response coordination app for emergency dispatch teams. It brings incident intake, live ambulance availability, nearest-unit dispatch, crew response progress, hospital handover, and an audit trail into one Flutter workspace.

Dispatchers can report incidents and send the closest available unit. Crews see their assigned responses, choose the receiving hospital, document patient care, and sign the handover. Citizens can request assistance and follow their own response without seeing staff-only or clinical details. Administrators manage accounts, invitations, fleet readiness, hospitals, scheduled maintenance, response targets, and reports.

Serverpod is the application backend. The Flutter client uses the generated, typed Serverpod client. Serverpod generates the PostgreSQL ORM and migrations from Dart model declarations. The server validates every workflow transition, persists incidents and audit events, streams live snapshots, ranks available units by Haversine distance, and serializes competing dispatch requests under a database lock. Account authentication, role and organization scoping, one-time invitations, password recovery, crew assignments, hospital records, maintenance, analytics, and signed handover reports are implemented on Serverpod.

## AI and source disclosure

AI coding assistants were used during implementation. This project enhances the existing Apache-2.0 ambulance-dispatch-management-system project by Sajed Lopez Mendoza: https://github.com/qppd/ambulance-dispatch-management-system. That project was present in the user's workspace before this hackathon. Its original license, attribution, dispatch domain models, map component, and palette are retained. The Serverpod backend, data models and migrations, generated client, accounts and access rules, persistent dispatch workflows, application interface, build/package tooling, and new Serverpod test coverage were added for this submission. The project combines the Apache-2.0 components and this new application work; retain the original license and notice.

## Platform

Flutter web, served with the Serverpod API. The demo uses fictional incidents and fleet data. Map tiles are provided by OpenStreetMap.

## Build and run

Requirements: Docker Engine or OrbStack and a stable internet connection for the first image build and map tiles.

1. Download and unpack the `adms-dispatch-judge-test` release archive.
2. From the extracted project root, run `./scripts/run-judge.sh`.
3. Open `http://localhost:8182`, select **Start dispatch demo**, and use the fictional simulation.
4. To stop it, run `docker compose --env-file .local/judge.env -f compose.judge.yaml down`. The database is retained in the local Docker volume.

The script generates private, random local database and service secrets. PostgreSQL and the Serverpod API are reachable only inside Docker; the browser connects through the same-origin web proxy. A regular source checkout can also use the local development steps in the repository README.

## Verification

137 Flutter tests, 23 Serverpod backend tests, and 2 map-proxy route tests passed. The release web app was compiled with Flutter 3.47.7. A live dispatch smoke test covers concurrent unit assignment; a separate live multi-role test covers citizen privacy, crew handover, session revocation, and logout.

## Submission links

- Repository: https://github.com/kris70lesgo/welcore
- Judge test build: https://welcore.serverpod.space/ (Serverpod Cloud free trial through 14 November 2026; Starter is $5/month after the trial if it remains active.)
- Public demonstration video (YouTube or Vimeo, under two minutes): record and paste its public URL into BuilderBase.

The cloud trial covers the judging period through 20 October 2026. The code author needs to decide before the trial ends whether to keep the project online on the paid Starter plan or stop it.
