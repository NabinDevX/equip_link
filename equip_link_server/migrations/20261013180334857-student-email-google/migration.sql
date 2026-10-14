BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "student_email_verification_challenge" (
    "id" bigserial PRIMARY KEY,
    "challengeId" text NOT NULL,
    "authUserId" uuid NOT NULL,
    "email" text NOT NULL,
    "codeHash" text NOT NULL,
    "salt" text NOT NULL,
    "issuedAt" timestamp without time zone NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "attempts" bigint NOT NULL,
    "maxAttempts" bigint NOT NULL,
    "consumed" boolean NOT NULL,
    "requestIp" text,
    "userAgent" text
);

-- Indexes
CREATE UNIQUE INDEX "student_email_challenge_id_idx" ON "student_email_verification_challenge" USING btree ("challengeId");
CREATE INDEX "student_email_challenge_user_idx" ON "student_email_verification_challenge" USING btree ("authUserId");
CREATE INDEX "student_email_challenge_email_idx" ON "student_email_verification_challenge" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "student_identity" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "googleProviderIdentity" text,
    "studentEmail" text,
    "emailVerified" boolean NOT NULL,
    "verifiedAt" timestamp without time zone,
    "lastRevalidatedAt" timestamp without time zone,
    "revalidationDueAt" timestamp without time zone,
    "eligibilityStatus" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "student_identity_auth_user_idx" ON "student_identity" USING btree ("authUserId");
CREATE UNIQUE INDEX "student_identity_google_idx" ON "student_identity" USING btree ("googleProviderIdentity");
CREATE UNIQUE INDEX "student_identity_email_idx" ON "student_identity" USING btree ("studentEmail");


--
-- MIGRATION VERSION FOR equip_link
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('equip_link', '20261013180334857-student-email-google', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261013180334857-student-email-google', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
