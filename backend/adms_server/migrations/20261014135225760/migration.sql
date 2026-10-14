BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "dispatch_care_report" (
    "id" bigserial PRIMARY KEY,
    "workspaceId" bigint NOT NULL,
    "incidentId" bigint NOT NULL,
    "patientName" text NOT NULL,
    "age" bigint,
    "condition" text NOT NULL,
    "pulse" bigint,
    "systolic" bigint,
    "diastolic" bigint,
    "oxygenSaturation" bigint,
    "treatment" text NOT NULL,
    "notes" text NOT NULL,
    "handedOverTo" text NOT NULL,
    "signedOff" boolean NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "dispatch_care_report_incidentid_idx" ON "dispatch_care_report" USING btree ("incidentId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "dispatch_hospital" (
    "id" bigserial PRIMARY KEY,
    "workspaceId" bigint NOT NULL,
    "name" text NOT NULL,
    "address" text NOT NULL,
    "phone" text NOT NULL,
    "latitude" double precision NOT NULL,
    "longitude" double precision NOT NULL,
    "active" boolean NOT NULL
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "dispatch_incident" ADD COLUMN "reporterAccountId" bigint;
ALTER TABLE "dispatch_incident" ADD COLUMN "destinationHospitalId" bigint;
ALTER TABLE "dispatch_incident" ADD COLUMN "destinationHospitalName" text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "dispatch_maintenance" (
    "id" bigserial PRIMARY KEY,
    "workspaceId" bigint NOT NULL,
    "unitId" bigint NOT NULL,
    "title" text NOT NULL,
    "notes" text NOT NULL,
    "dueAt" timestamp without time zone NOT NULL,
    "cost" double precision NOT NULL,
    "status" text NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "dispatch_session" ADD COLUMN "name" text NOT NULL DEFAULT 'Manila operations'::text;
ALTER TABLE "dispatch_session" ADD COLUMN "isDemo" boolean NOT NULL DEFAULT true;
ALTER TABLE "dispatch_session" ADD COLUMN "autoDispatch" boolean NOT NULL DEFAULT false;
ALTER TABLE "dispatch_session" ADD COLUMN "responseTargetMinutes" bigint NOT NULL DEFAULT 10;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "dispatch_unit" ADD COLUMN "plateNumber" text;
ALTER TABLE "dispatch_unit" ADD COLUMN "unitType" text;
ALTER TABLE "dispatch_unit" ADD COLUMN "active" boolean NOT NULL DEFAULT true;
ALTER TABLE "dispatch_unit" ADD COLUMN "locationUpdatedAt" timestamp without time zone;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "staff_account" (
    "id" bigserial PRIMARY KEY,
    "workspaceId" bigint NOT NULL,
    "email" text NOT NULL,
    "name" text NOT NULL,
    "role" text NOT NULL,
    "passwordSalt" text NOT NULL,
    "passwordHash" text NOT NULL,
    "active" boolean NOT NULL,
    "assignedUnitId" bigint,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "staff_account_email_idx" ON "staff_account" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "staff_invite" (
    "id" bigserial PRIMARY KEY,
    "workspaceId" bigint NOT NULL,
    "tokenHash" text NOT NULL,
    "email" text NOT NULL,
    "role" text NOT NULL,
    "assignedUnitId" bigint,
    "recoveryAccountId" bigint,
    "expiresAt" timestamp without time zone NOT NULL,
    "usedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "staff_invite_tokenhash_idx" ON "staff_invite" USING btree ("tokenHash");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "staff_session" (
    "id" bigserial PRIMARY KEY,
    "accountId" bigint NOT NULL,
    "tokenHash" text NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "staff_session_tokenhash_idx" ON "staff_session" USING btree ("tokenHash");


--
-- MIGRATION VERSION FOR adms
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('adms', '20261014135225760', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261014135225760', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();


COMMIT;
