BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "student_identity" ADD COLUMN "university" text;
ALTER TABLE "student_identity" ADD COLUMN "studentIdCardPath" text;
ALTER TABLE "student_identity" ADD COLUMN "studentIdExpiresAt" timestamp without time zone;
ALTER TABLE "student_identity" ADD COLUMN "studentIdCardVerified" boolean NOT NULL DEFAULT false;

--
-- MIGRATION VERSION FOR equip_link
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('equip_link', '20261013193207736-student-id-verification', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261013193207736-student-id-verification', "timestamp" = now();

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
