-- author : cbarange
-- date : 07th Junuary 2021
-- file : ddl_posthoop_post.sql
-- base : posthoop
-- role : create database, schema and table for post

-- --- CREATE ROLE DATABASE SCHEMA ---
CREATE ROLE posthoop WITH 
  LOGIN
  NOSUPERUSER
  NOCREATEDB
  NOCREATEROLE
  INHERIT
  NOREPLICATION
  CONNECTION
  LIMIT -1
  PASSWORD 'Epsi2020!';

CREATE DATABASE posthoop
  WITH 
  OWNER = posthoop
  TEMPLATE = template0
  ENCODING = 'UTF8'
  CONNECTION LIMIT = -1;

\c posthoop

CREATE SCHEMA posthoop AUTHORIZATION posthoop;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

SET ROLE posthoop;

-- --- CREATE TABLES ---
CREATE TABLE posthoop."post" (
  "uid" uuid PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "text" varchar NOT NULL,
  "uid_user" uuid NOT NULL,
  "url_image" uuid[],
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp
);
ALTER TABLE posthoop."post" OWNER TO posthoop;

CREATE TABLE posthoop."tag_post" (
  "uid_post" uuid,
  "uid_tag" uuid
);
ALTER TABLE posthoop."tag_post" OWNER TO posthoop;

CREATE TABLE posthoop."tag" (
  "uid" uuid PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "text" varchar NOT NULL,
  "color" varchar DEFAULT 'white',
  "created_at" timestamp DEFAULT (now())
);
ALTER TABLE posthoop."tag" OWNER TO posthoop;

CREATE TABLE posthoop."comment" (
  "uid" uuid PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "text" varchar NOT NULL,
  "uid_user" uuid NOT NULL,
  "uid_post" uuid NOT NULL,
  "url_image" uuid[],
  "created_at" timestamp DEFAULT (now())
);
ALTER TABLE posthoop."comment" OWNER TO posthoop;

-- --- FOREIGN KEY ---
ALTER TABLE posthoop."tag_post" ADD FOREIGN KEY ("uid_post") REFERENCES posthoop."post" ("uid");

ALTER TABLE posthoop."tag_post" ADD FOREIGN KEY ("uid_tag") REFERENCES posthoop."tag" ("uid");

ALTER TABLE posthoop."comment" ADD FOREIGN KEY ("uid_post") REFERENCES posthoop."post" ("uid");
