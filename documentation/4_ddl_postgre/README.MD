# DDL: создание, изменение и удаление объектов в PostgreSQL

## Роли
Используются для ограничения прав с работой какой-либо сущностью в БД
Были созданы 2 роли:
```postgresql
CREATE ROLE main_admin WITH SUPERUSER CREATEDB CREATEROLE CONNECTION LIMIT 2;
CREATE ROLE common_dml_user WITH NOCREATEDB NOCREATEROLE;
```

## Табличные пространства
Используются для определения в каком каталоге сервера хранить данные.
Были созданы 2 табличных пространства для индексов и всего остального
Предварительная настройка на сервере:
```shell
mkdir /var/lib/marketplace_data
chown postgres:postgres /var/lib/marketplace_data
mkdir /var/lib/marketplace_indexes
chown postgres:postgres /var/lib/marketplace_indexes
```

Далее создаем сами табличные пространства через SQL:
```postgresql
CREATE TABLESPACE dbspace
    OWNER main_admin
    LOCATION '/var/lib/marketplace_data';
CREATE TABLESPACE indexspace
    OWNER main_admin
    LOCATION '/var/lib/marketplace_indexes';
```

## Создание БД и схемы
БД используется для определения большого пространтсва, где будут лежать все сущности.
Схема используется для логического разделения таблиц.
Создание осуществляется следующими командами:
```postgresql
CREATE DATABASE marketplace
    WITH OWNER main_admin
    TABLESPACE dbspace;
\connect marketplace;
SET search_path TO marketplace;
CREATE SCHEMA shop;
```

## Изменения
- Был создан раздел /documentation куда будут выноситься все README.MD файлы
- В Liquibase обновление БД теперь идет по changelog_V2.sql файлу, так как структура БД уже устоялась
- Добавлен init_db_script.sql для предварительной настройки сервера БД
- Для всех таблиц и индексов созданы табличные пространства
