-- liquibase formatted sql

-- changeset snegov-ds:1 endDelimiter:/
CREATE SEQUENCE manufacturer_seq
    AS BIGINT
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
/
create table manufacturer
(
    id                bigint default nextval('manufacturer_seq') not null
        primary key,
    name              varchar(100)                               not null
        constraint unique_manufacturer_name
            unique,
    address           text                                       not null,
    working_days_mode varchar(50)                                not null,
    phone             varchar(12)                                not null
        constraint unique_manufacturer_phone
            unique,
    link_url          varchar(200)                               not null
        constraint unique_link_url
            unique,
    description       text                                       not null,
    working_time_mode varchar(11)
        constraint working_time_mode_pattern_chk
            check (regexp_match((working_time_mode)::text, '^\d\d:\d\d-\d\d:\d\d$'::text) IS NOT NULL)
)
    TABLESPACE dbspace;
comment on table manufacturer is 'Производитель продуктов';
comment on column manufacturer.id is 'Идентификатор';
comment on column manufacturer.name is 'Название компании производителя';
comment on column manufacturer.address is 'Юридический адрес производителя';
comment on column manufacturer.working_days_mode is 'Режим и время работы';
comment on column manufacturer.phone is 'Номер телефона';
comment on column manufacturer.link_url is 'URL на страницу компании производителя';
comment on column manufacturer.description is 'Описание компании производителя';
/
CREATE SEQUENCE provider_seq
    AS BIGINT
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
/
create table provider
(
    id      bigint default nextval('provider_seq') not null
        primary key,
    name    varchar(100)                           not null
        constraint unique_provider_name
            unique,
    email   varchar(100)                           not null
        constraint unique_provider_email
            unique
        constraint email_pattern_chk
            check ((email)::text ~~ '%@%'::text),
    address text                                   not null,
    phone   varchar(12)                            not null
        constraint unique_provider_phone
            unique
        constraint phone_pattern_chk
            check (regexp_match((phone)::text, '^\+\d{11}$'::text) IS NOT NULL)
)
    TABLESPACE dbspace;
comment on table provider is 'Поставщик';
comment on column provider.id is 'Идентификатор';
comment on column provider.name is 'Название компании поставщика';
comment on column provider.email is 'email';
comment on column provider.address is 'Юридический адрес';
comment on column provider.phone is 'Телефон';
/
create table manufacturer_provider
(
    manufacturer_id bigint not null
        constraint manufacturer_id_fkey
            references manufacturer,
    provider_id     bigint not null
        constraint provider_id_fkey
            references provider,
    primary key (manufacturer_id, provider_id)
)
    TABLESPACE dbspace;

comment on table manufacturer_provider is 'Производитель-поставщик';
comment on column manufacturer_provider.manufacturer_id is 'Идентификатор производителя';
comment on column manufacturer_provider.provider_id is 'Идентификатор поставщика';

create index manufacturer_id_idx
    on manufacturer_provider (manufacturer_id)
TABLESPACE indexspace;
create index provider_id_idx
    on manufacturer_provider (provider_id)
TABLESPACE indexspace;
/
CREATE SEQUENCE price_list_seq
    AS BIGINT
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
/
create table price_list
(
    id        bigint default nextval('price_list_seq') not null
        primary key,
    price     numeric,
    date_from timestamp,
    date_to   timestamp
)
    TABLESPACE dbspace;
comment on table price_list is 'Список цен на товары';
comment on column price_list.id is 'Идентификатор';
comment on column price_list.price is 'Цена на товар';
comment on column price_list.date_from is 'Начало действия стоимости товара';
comment on column price_list.date_to is 'Конец действия стоимости товара';
/
CREATE SEQUENCE parameter_seq
    AS BIGINT
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
/
create table parameter
(
    id   bigint default nextval('parameter_seq') not null
        primary key,
    name varchar(100)                            not null
        constraint unique_parameter_name
            unique
)
    TABLESPACE dbspace;

comment on table parameter is 'Названия параметров и характеристик продуктов';
comment on column parameter.id is 'Идентификатор';
comment on column parameter.name is 'Название параметра';
/
CREATE SEQUENCE category_seq
    AS BIGINT
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
/
create table category
(
    id          bigint default nextval('category_seq') not null
        primary key,
    name        varchar(70)                            not null
        constraint unique_category_name
            unique,
    subcategory bigint                                 not null
        constraint subcategory_fkey
            references category
)
    TABLESPACE dbspace;

comment on table category is 'Категория товара';
comment on column category.id is 'Идентификатор';
comment on column category.name is 'Название';
comment on column category.subcategory is 'Подкатегория товара';

create index subcategory_idx
    on category (subcategory)
    TABLESPACE indexspace;
/
CREATE SEQUENCE client_seq
    AS BIGINT
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
/
create table client
(
    id         bigint default nextval('client_seq') not null
        primary key,
    first_name varchar(100)                         not null,
    last_name  varchar(100)                         not null,
    email      varchar(100)                         not null
        constraint unique_client_email
            unique
        constraint email_pattern_chk
            check ((email)::text ~~ '%@%'::text),
    phone      varchar(12)                          not null
        constraint unique_client_phone
            unique
        constraint phone_pattern_chk
            check (regexp_match((phone)::text, '^\+\d{11}$'::text) IS NOT NULL),
    birth_date date                                 not null
        constraint age_chk
            check ((date_part('year'::text,
                              age((CURRENT_DATE)::timestamp with time zone, (birth_date)::timestamp with time zone)) >
                    (18)::double precision) AND (date_part('year'::text, age((CURRENT_DATE)::timestamp with time zone,
                                                                             (birth_date)::timestamp with time zone)) <
                                                 (120)::double precision))
)
    TABLESPACE dbspace;

comment on table client is 'Клиент';
comment on column client.id is 'Идентификатор';
comment on column client.first_name is 'Имя';
comment on column client.last_name is 'Фамилия';
comment on column client.email is 'email';
comment on column client.phone is 'Телефон';
comment on column client.birth_date is 'Дата рождения';

create index client_email_idx
    on client (email)
    TABLESPACE indexspace;
comment on index client_email_idx is 'Получение данных клиента по электронной почте';

create index client_phone_idx
    on client (phone)
    TABLESPACE indexspace;
comment on index client_phone_idx is 'Получение данных клиента по номеру телефона';
/
CREATE SEQUENCE client_history_seq
    AS BIGINT
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
/
CREATE TABLE client_history
(
    id             bigint NOT NULL DEFAULT nextval('client_history_seq'),
    client_id_fkey BIGINT NOT NULL,
    email          varchar(100),
    phone          varchar(12),
    CONSTRAINT client_history_pkey PRIMARY KEY (id),
    CONSTRAINT fk_client_id_fkey FOREIGN KEY (client_id_fkey) REFERENCES client (id)
)
    TABLESPACE dbspace;
/
CREATE FUNCTION log_client_history() RETURNS trigger
AS
$$
BEGIN
    INSERT INTO client_history SELECT nextval('client_history_seq'), OLD.id, OLD.email, OLD.phone;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_client_history
    AFTER UPDATE
    ON client
    FOR EACH ROW
EXECUTE FUNCTION log_client_history();
/
CREATE SEQUENCE product_seq
    AS BIGINT
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
/
create table product
(
    id          bigint default nextval('product_seq') not null
        primary key,
    name        varchar(100)                          not null,
    fk_provider bigint                                not null
        constraint fk_provider_fkey
            references provider,
    fk_category bigint                                not null
        constraint fk_category_fkey
            references category,
    description text                                  not null,
    fk_price    bigint                                not null
        constraint price_id_fkey
            references price_list
        constraint price_product_gt_zero_chk
            check (fk_price > 0)
)
    TABLESPACE dbspace;

comment on table product is 'Товар';
comment on column product.id is 'Идентификатор';
comment on column product.name is 'Название';
comment on column product.fk_provider is 'Внешний ключ поставщика';
comment on column product.fk_category is 'Внешний ключ категории';
comment on column product.description is 'Описание';
comment on column product.fk_price is 'Цена';

create index fk_category_idx
    on product (fk_category)
    TABLESPACE indexspace;

create index fk_provider_idx
    on product (fk_provider)
    TABLESPACE indexspace;

create index product_by_category_idx
    on product (fk_category)
    TABLESPACE indexspace;
comment on index product_by_category_idx is 'Получение данных о товаре по категории';

create index product_by_filters_idx
    on product (name, fk_category, fk_price)
    TABLESPACE indexspace;
comment on index product_by_filters_idx is 'Получение данных о товаре по основным фильтрам';
/
create table product_parameter
(
    parameter_id bigint       not null
        constraint parameter_id_fkey
            references parameter,
    product_id   bigint       not null
        constraint product_id_fkey
            references product,
    value        varchar(100) not null,
    primary key (parameter_id, product_id)
)
    TABLESPACE dbspace;

comment on table product_parameter is 'Товар-параметер';
comment on column product_parameter.parameter_id is 'Идентификатор параметра';
comment on column product_parameter.product_id is 'Идентификатор товара';
comment on column product_parameter.value is 'Значение параметра товара';

create index parameter_id_idx
    on product_parameter (parameter_id)
    TABLESPACE indexspace;

create index product_id_idx
    on product_parameter (product_id)
    TABLESPACE indexspace;

create index product_parameter_by_ids_idx
    on product_parameter (parameter_id, product_id)
    TABLESPACE indexspace;
comment on index product_parameter_by_ids_idx is 'Получение значения параметра товара по id параметра и товара';
/
CREATE SEQUENCE order_seq
    AS BIGINT
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
/
create type order_state as enum ('CANCELED', 'NEW', 'WAIT_SELLER', 'SHIPPED', 'WAIT_CLIENT', 'EXECUTED');
create table purchase_order
(
    id        bigint default nextval('order_seq') not null
        constraint order_pkey
            primary key,
    fk_client bigint                              not null
        constraint fk_client_fkey
            references client,
    state     shop.order_state                    not null,
    date      timestamp                           not null
)
    TABLESPACE dbspace;

comment on table purchase_order is 'Заказ';
comment on column purchase_order.id is 'Идентификатор';
comment on column purchase_order.fk_client is 'Внешний ключ клиента';
comment on column purchase_order.state is 'Статус заказа';
comment on column purchase_order.date is 'Время заказа';

create index fk_client_idx
    on purchase_order (fk_client)
    TABLESPACE indexspace;
/
CREATE SEQUENCE order_line_seq
    AS BIGINT
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
/
create table order_line
(
    id            bigint default nextval('order_line_seq') not null
        primary key,
    fk_product    bigint                                   not null
        constraint fk_product_fkey
            references product,
    product_count smallint,
    fk_order      bigint                                   not null
        constraint fk_order_fkey
            references purchase_order
)
    TABLESPACE dbspace;
comment on table order_line is 'Линия одного товара в заказе';
comment on column order_line.id is 'Идентификатор';
comment on column order_line.fk_product is 'Внешний коюч товара';
comment on column order_line.product_count is 'Количество товара в заказе';
comment on column order_line.fk_order is 'Внешний ключ заказа';
/