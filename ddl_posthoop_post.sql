-- author : cbarange
-- date : 22th december 2020
-- file : ddl_posthoop_post.sql
-- base : posthoop_post
-- role : create database, schema and table

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

CREATE DATABASE posthoop_post
  WITH 
  OWNER = posthoop
  TEMPLATE = template0
  ENCODING = 'UTF8'
  CONNECTION LIMIT = -1;

\c posthoop_post


CREATE SCHEMA posthoop_post AUTHORIZATION posthoop;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

SET ROLE posthoop;
-- --- CREATE TABLES ---
CREATE TABLE posthoop_post."post" (
  "uid" uuid PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "text" varchar NOT NULL,
  "uid_user" uuid NOT NULL,
  "url_image" uuid[],
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp
);
ALTER TABLE posthoop_post."post" OWNER TO posthoop;

CREATE TABLE posthoop_post."tag_post" (
  "uid_post" uuid,
  "uid_tag" uuid
);
ALTER TABLE posthoop_post."tag_post" OWNER TO posthoop;

CREATE TABLE posthoop_post."tag" (
  "uid" uuid PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "text" varchar NOT NULL,
  "color" varchar DEFAULT 'white',
  "created_at" timestamp DEFAULT (now())
);
ALTER TABLE posthoop_post."tag" OWNER TO posthoop;

CREATE TABLE posthoop_post."comment" (
  "uid" uuid PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "text" varchar NOT NULL,
  "uid_user" uuid NOT NULL,
  "uid_post" uuid NOT NULL,
  "url_image" uuid[],
  "created_at" timestamp DEFAULT (now())
);
ALTER TABLE posthoop_post."comment" OWNER TO posthoop;


ALTER TABLE posthoop_post."tag_post" ADD FOREIGN KEY ("uid_post") REFERENCES posthoop_post."post" ("uid");

ALTER TABLE posthoop_post."tag_post" ADD FOREIGN KEY ("uid_tag") REFERENCES posthoop_post."tag" ("uid");

ALTER TABLE posthoop_post."comment" ADD FOREIGN KEY ("uid_post") REFERENCES posthoop_post."post" ("uid");

-- VIEW
CREATE ROLE posthoop_view WITH 
  LOGIN
  NOSUPERUSER
  NOCREATEDB
  NOCREATEROLE
  INHERIT
  NOREPLICATION
  CONNECTION
  LIMIT -1
  PASSWORD 'Epsi2020!';

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE "posthoop_post"."post", "posthoop_post"."tag_post", "posthoop_post"."tag", "posthoop_post"."comment" TO posthoop_view;

CREATE SCHEMA "v1_0" AUTHORIZATION posthoop_view;

CREATE VIEW "v1_0"."post" AS
  select uid, text, uid_user, url_image, created_at, updated_at
  from posthoop_post.post;

ALTER VIEW "v1_0"."post" OWNER TO posthoop_view;

CREATE VIEW "v1_0"."comment" AS
  select uid, text, uid_user, url_image, created_at
  from posthoop_post.post;

ALTER VIEW "v1_0"."comment" OWNER TO posthoop_view;

CREATE VIEW "v1_0"."tag" AS
  select uid, text, color
  from posthoop_post.tag;

ALTER VIEW "v1_0"."tag" OWNER TO posthoop_view;

CREATE VIEW "v1_0"."tag_by_post" AS
  SELECT uid_post, uid_tag, text, color, created_at
  from posthoop_post.tag_post TP
  LEFT JOIN posthoop_post.tag T ON T.uid = TP.uid_tag;

ALTER VIEW "v1_0"."tag_by_post" OWNER TO posthoop_view;
