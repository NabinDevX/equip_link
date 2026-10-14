BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "email_otp_challenge" (
    "id" bigserial PRIMARY KEY,
    "challengeId" text NOT NULL,
    "email" text NOT NULL,
    "codeHash" text NOT NULL,
    "salt" text NOT NULL,
    "issuedAt" timestamp without time zone NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "attempts" bigint NOT NULL,
    "maxAttempts" bigint NOT NULL,
    "consumed" boolean NOT NULL,
    "requestIp" text,
    "userAgent" text,
    "preAuthNonce" text
);

-- Indexes
CREATE UNIQUE INDEX "email_otp_challenge_id_idx" ON "email_otp_challenge" USING btree ("challengeId");
CREATE INDEX "email_otp_email_idx" ON "email_otp_challenge" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "equipment_category" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "slug" text NOT NULL,
    "description" text,
    "iconName" text,
    "isActive" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "equipment_category_slug_idx" ON "equipment_category" USING btree ("slug");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "equipment_listing" (
    "id" bigserial PRIMARY KEY,
    "ownerId" uuid NOT NULL,
    "categoryId" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "hourlyRate" double precision,
    "dailyRate" double precision NOT NULL,
    "securityDeposit" double precision NOT NULL,
    "condition" text NOT NULL,
    "status" text NOT NULL,
    "locationCampus" text NOT NULL,
    "imageUrls" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "equipment_listing_owner_idx" ON "equipment_listing" USING btree ("ownerId");
CREATE INDEX "equipment_listing_category_idx" ON "equipment_listing" USING btree ("categoryId");
CREATE INDEX "equipment_listing_status_idx" ON "equipment_listing" USING btree ("status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "handover_confirmation" (
    "id" bigserial PRIMARY KEY,
    "rentalRequestId" bigint NOT NULL,
    "type" text NOT NULL,
    "confirmedByOwner" boolean NOT NULL,
    "confirmedByRenter" boolean NOT NULL,
    "handoverCode" text,
    "itemConditionNotes" text,
    "confirmedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "handover_confirmation_rental_idx" ON "handover_confirmation" USING btree ("rentalRequestId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "rental_request" (
    "id" bigserial PRIMARY KEY,
    "listingId" bigint NOT NULL,
    "renterId" uuid NOT NULL,
    "ownerId" uuid NOT NULL,
    "startDate" timestamp without time zone NOT NULL,
    "endDate" timestamp without time zone NOT NULL,
    "totalDays" bigint NOT NULL,
    "dailyRate" double precision NOT NULL,
    "totalAmount" double precision NOT NULL,
    "securityDeposit" double precision NOT NULL,
    "status" text NOT NULL,
    "notes" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "rental_request_listing_idx" ON "rental_request" USING btree ("listingId");
CREATE INDEX "rental_request_renter_idx" ON "rental_request" USING btree ("renterId");
CREATE INDEX "rental_request_owner_idx" ON "rental_request" USING btree ("ownerId");
CREATE INDEX "rental_request_status_idx" ON "rental_request" USING btree ("status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "rental_review" (
    "id" bigserial PRIMARY KEY,
    "rentalRequestId" bigint NOT NULL,
    "reviewerId" uuid NOT NULL,
    "revieweeId" uuid NOT NULL,
    "listingId" bigint NOT NULL,
    "rating" bigint NOT NULL,
    "comment" text,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "rental_review_rental_idx" ON "rental_review" USING btree ("rentalRequestId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "rental_status_history" (
    "id" bigserial PRIMARY KEY,
    "rentalRequestId" bigint NOT NULL,
    "status" text NOT NULL,
    "changedBy" uuid NOT NULL,
    "notes" text,
    "timestamp" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "rental_status_history_rental_idx" ON "rental_status_history" USING btree ("rentalRequestId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "student_profile" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "fullName" text NOT NULL,
    "email" text NOT NULL,
    "university" text NOT NULL,
    "studentIdNumber" text,
    "phoneNumber" text,
    "avatarUrl" text,
    "isVerified" boolean NOT NULL,
    "bio" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "student_profile_auth_user_idx" ON "student_profile" USING btree ("authUserId");
CREATE UNIQUE INDEX "student_profile_email_idx" ON "student_profile" USING btree ("email");


--
-- MIGRATION VERSION FOR equip_link
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('equip_link', '20261013145759872', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261013145759872', "timestamp" = now();

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
