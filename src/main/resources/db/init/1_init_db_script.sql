-- Предварительно необходимо создать каталоги в поднятом сервере Postgres
-- # mkdir /var/lib/marketplace_data
-- # chown postgres:postgres /var/lib/marketplace_data
-- # mkdir /var/lib/marketplace_indexes
-- # chown postgres:postgres /var/lib/marketplace_indexes
CREATE ROLE main_admin WITH SUPERUSER CREATEDB CREATEROLE CONNECTION LIMIT 2;
CREATE ROLE common_dml_user WITH NOCREATEDB NOCREATEROLE;
CREATE TABLESPACE dbspace
    OWNER main_admin
    LOCATION '/var/lib/marketplace_data';
CREATE TABLESPACE indexspace
    OWNER main_admin
    LOCATION '/var/lib/marketplace_indexes';
CREATE DATABASE marketplace
    WITH OWNER main_admin
    TABLESPACE dbspace;
\connect marketplace;
SET search_path TO marketplace;
CREATE SCHEMA shop;