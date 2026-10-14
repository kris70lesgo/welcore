# Serverpod Dispatch Implementation Plan

**Goal:** Complete a demonstrable ambulance dispatch workflow inside the existing ADMS Flutter project with Serverpod owning persistence and business rules.

**Architecture:** Add a generated Serverpod 4 server/client pair under `backend/`. The existing Flutter app gets a Serverpod entrypoint using the existing domain lifecycle, map and palette; preserve the Firebase entrypoint for reference. PostgreSQL stores units, incidents, audit events and scoped demo sessions. The server validates input, assigns units atomically, enforces status transitions and streams authoritative snapshots.

**Tech Stack:** Flutter, Dart, Serverpod 4, PostgreSQL, flutter_map.

## Scope and choices
A small finished dispatch flow is the target. Rewriting every Firebase administrative feature would risk an incomplete submission; an ornamental Serverpod endpoint would fail the user's intent. Implement incident intake, nearest-unit dispatch, crew progress, cancellation, audit trail, metrics and real-time updates as an integrated Serverpod workspace. Demo sessions isolate each visitor and are explicitly labeled simulations.

## Tasks
1. Set up a local Flutter/Dart SDK if absent; generate Serverpod scaffold and client.
2. Define persisted models, generate code and versioned migrations.
3. Implement isolated demo session, seeded units, validated intake, nearest-unit assignment, sequential status updates, cancellation, snapshots and audit.
4. Add Flutter dashboard in `source/flutter/adms/lib/features/serverpod/`, generated client dependency and default Serverpod startup. Retain Firebase startup in `lib/main_firebase.dart`.
5. Add integration tests for persistence, isolation, invalid input, unit contention, lifecycle, cancellation and streaming; widget tests for the new workspace.
6. Run analyzer, server integration tests, Flutter tests, release web build and a live client smoke test; inspect the browser UI.
7. Document startup commands, demo script, attribution, tested scope and submission materials.

## Constraints
Do not remove the Apache license or original author attribution. Do not imply legacy Firebase administration is migrated. This is a hackathon simulation, not an operational emergency service. Do not publish or submit without user instruction. Keep tooling and credentials out of submitted source.
