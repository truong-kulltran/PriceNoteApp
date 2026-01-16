BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "categories" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "type" text NOT NULL,
    "icon" text,
    "color" text,
    "isDefault" boolean NOT NULL DEFAULT true
);

-- Indexes
CREATE UNIQUE INDEX "name_idx" ON "categories" USING btree ("name");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "transactions" (
    "id" bigserial PRIMARY KEY,
    "walletId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "type" text NOT NULL,
    "amount" double precision NOT NULL,
    "transactionDate" timestamp without time zone NOT NULL,
    "categoryId" bigint,
    "note" text,
    "source" text NOT NULL DEFAULT 'manual'::text,
    "aiConfidenceScore" double precision,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "wallet_idx" ON "transactions" USING btree ("walletId");
CREATE INDEX "user_date_idx" ON "transactions" USING btree ("userId", "transactionDate");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "users" (
    "id" bigserial PRIMARY KEY,
    "email" text NOT NULL,
    "name" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "email_idx" ON "users" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "wallets" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "name" text NOT NULL,
    "currency" text NOT NULL,
    "initialBalance" double precision NOT NULL,
    "currentBalance" double precision NOT NULL,
    "status" text NOT NULL DEFAULT 'active'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "user_wallet_idx" ON "wallets" USING btree ("userId");


--
-- MIGRATION VERSION FOR learn_dart_serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('learn_dart_serverpod', '20260116083847727', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260116083847727', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
