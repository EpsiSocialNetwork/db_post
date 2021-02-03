-- author : jpeguet
-- date : 7th january 2021
-- file : drop_posthoop_post.sql
-- base : posthoop_post
-- role : drop all

select pg_terminate_backend(pid) from pg_stat_activity where datname='posthoop';
DROP DATABASE IF EXISTS posthoop_post;
DROP USER IF EXISTS posthoop;