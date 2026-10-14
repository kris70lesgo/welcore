# Hackathon project materials

## Project name
Welcore

## Short description
A Serverpod-powered Flutter dispatch desk that turns a reported incident into a coordinated ambulance response, with nearest-unit assignment, live crew progress, and a durable audit timeline.

## Problem and user
A dispatcher needs to know which incidents are awaiting help, which ambulances are free, and what stage each crew has reached. Switching between disconnected lists makes this harder. Welcore puts the incident queue, location map, unit readiness, and response controls in one workspace.

## Serverpod contribution
Serverpod is the core backend. YAML models generate both PostgreSQL ORM code and the typed Dart client. The server validates reports, ranks available ambulances by Haversine distance, claims a unit under a PostgreSQL row lock, enforces the response lifecycle, stores audit events, and streams authoritative snapshots through WebSockets. It is not a static UI with an unused endpoint.

## Two-minute demo script

Use the hosted app and show a real flow from the interface. Keep the final video under two minutes; the rules require a public YouTube or Vimeo URL. A tighter 100-second walkthrough is in [DEMO_VIDEO.md](DEMO_VIDEO.md).

## Source disclosure

This work extends the existing Apache-licensed ADMS Flutter project by Sajed Lopez Mendoza: https://github.com/qppd/ambulance-dispatch-management-system. The base source was already present in the user's folder. Its domain models, map widget, and palette are reused. The Serverpod backend, generated protocol/migrations, isolated demo sessions, dispatch workspace, scripts, and workflow verification are new additions. Do not describe the full inherited project as newly authored during the event.

## Submission checklist

Event: https://builderbase.com/event/build-something-real-the-serverpod-hackathon

Official rules: https://tinyurl.com/SP-rules. Deadline: 14 October 2026, 23:59 CEST (15 October, 03:29 IST). The event requires (1) a source repository URL, (2) an English feature/build/run description, (3) a working project/test build freely accessible through the end of judging on 20 October, and (4) a publicly available YouTube/Vimeo demonstration video under two minutes. You are recording and uploading the video yourself; add its URL to BuilderBase. Do not submit without honestly disclosing the inherited source. The existing app is Apache-2.0 open source; the official rules allow open-source components when the entrant's project materially enhances the source project's features. The Serverpod backend, persistence, authentication and role scopes, dispatch operations, account flows, UI and tests are the enhancement. Review the final project timing/eligibility question with BuilderBase if unsure.

Repository and demo links are added below when published. Cloud deployment status is documented after launch. Submit through the registered BuilderBase account; the external final submission has not been made by the developer.

## Full app demo extension

Create an organization and save its recovery code. Show member invitations for a dispatcher, a crew bound to MEDIC 01, and a citizen. Sign into the citizen account and report an incident. Dispatch it from the administrator/dispatcher view. The crew chooses a hospital, records scene care, advances to hospital arrival and signs handover before completing the response. Show the citizen's tracking view without exposing clinical details.

Then show fleet editing, hospital editing, maintenance taking a unit out of service, automatic dispatch settings, response analytics, CSV/PDF export, and member deactivation revoking a live session. All these workflows now run on Serverpod; Firebase is retained only in the original reference source.
