-- author : cbarange
-- date : 22th december 2020
-- file : drop_posthoop.sql
-- base : posthoop
-- role : drop all

select pg_terminate_backend(pid) from pg_stat_activity where datname='posthoop';
DROP DATABASE IF EXISTS posthoop;
DROP USER IF EXISTS posthoop;