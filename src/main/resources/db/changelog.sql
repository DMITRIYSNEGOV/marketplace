-- liquibase formatted sql

-- changeset snegov-ds:1 endDelimiter:/
CREATE SEQUENCE parameter_seq
    AS BIGINT
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
/
CREATE TABLE parameter
(
    id   bigint       NOT NULL DEFAULT nextval('parameter_seq'),
    name varchar(100) NOT NULL,
    CONSTRAINT parameter_pkey PRIMARY KEY (id)
);

COMMENT
ON TABLE parameter IS 'Названия параметров и характеристик продуктов';

COMMENT
ON COLUMN parameter.id IS 'Идентификатор';
COMMENT
ON COLUMN parameter.name IS 'Название параметра';
/
CREATE SEQUENCE client_seq
    AS BIGINT
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
/
CREATE TABLE client
(
    id         bigint      NOT NULL DEFAULT nextval('client_seq'),
    first_name varchar(50) NOT NULL,
    last_name  varchar(50) NOT NULL,
    email      varchar(50) NOT NULL,
    phone      varchar(50) NOT NULL,
    birth_date date        NOT NULL,
    CONSTRAINT client_pkey PRIMARY KEY (id)
);

COMMENT
ON TABLE client IS 'Клиент';

COMMENT
ON COLUMN client.id IS 'Идентификатор';
COMMENT
ON COLUMN client.first_name IS 'Имя';
COMMENT
ON COLUMN client.last_name IS 'Фамилия';
COMMENT
ON COLUMN client.email IS 'email';
COMMENT
ON COLUMN client.phone IS 'Телефон';
COMMENT
ON COLUMN client.birth_date IS 'Дата рождения';
/
CREATE SEQUENCE category_seq
    AS BIGINT
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
/
CREATE TABLE category
(
    id          bigint      NOT NULL DEFAULT nextval('category_seq'),
    name        varchar(50) NOT NULL,
    subcategory bigint      NOT NULL,
    CONSTRAINT category_pkey PRIMARY KEY (id),
    CONSTRAINT subcategory_fkey FOREIGN KEY (subcategory) REFERENCES category (id)
);

CREATE INDEX subcategory_idx ON category
    (
     subcategory
        );

COMMENT
ON TABLE  category IS 'Категория товара';

COMMENT
ON COLUMN  category.id IS 'Идентификатор';
COMMENT
ON COLUMN  category.name IS 'Название';
COMMENT
ON COLUMN  category.subcategory IS 'Подкатегория товара';
/
CREATE SEQUENCE manufacturer_seq
    AS BIGINT
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
/
CREATE TABLE manufacturer
(
    id           bigint      NOT NULL DEFAULT nextval('manufacturer_seq'),
    name         varchar(50) NOT NULL,
    address      varchar(50) NOT NULL,
    working_mode varchar(50) NOT NULL,
    phone        varchar(50) NOT NULL,
    link_url     varchar(50) NOT NULL,
    description  varchar(50) NOT NULL,
    CONSTRAINT manufacturer_pkey PRIMARY KEY (id)
);

COMMENT
ON TABLE  manufacturer IS 'Производитель продуктов';

COMMENT
ON COLUMN  manufacturer.id IS 'Идентификатор';
COMMENT
ON COLUMN  manufacturer.name IS 'Название компании производителя';
COMMENT
ON COLUMN  manufacturer.address IS 'Юридический адрес производителя';
COMMENT
ON COLUMN  manufacturer.working_mode IS 'Режим и время работы';
COMMENT
ON COLUMN  manufacturer.phone IS 'Номер телефона';
COMMENT
ON COLUMN  manufacturer.link_url IS 'URL на страницу компании производителя';
COMMENT
ON COLUMN  manufacturer.description IS 'Описание компании производителя';
/
CREATE SEQUENCE provider_seq
    AS BIGINT
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
/
CREATE TABLE provider
(
    id      bigint      NOT NULL DEFAULT nextval('provider_seq'),
    name    varchar(50) NOT NULL,
    email   varchar(50) NOT NULL,
    address varchar(50) NOT NULL,
    phone   varchar(50) NOT NULL,
    CONSTRAINT provider_pkey PRIMARY KEY (id)
);

COMMENT
ON TABLE  provider IS 'Поставщик';

COMMENT
ON COLUMN  provider.id IS 'Идентификатор';
COMMENT
ON COLUMN  provider.name IS 'Название компании поставщика';
COMMENT
ON COLUMN  provider.email IS 'email';
COMMENT
ON COLUMN  provider.address IS 'Юридический адрес';
COMMENT
ON COLUMN  provider.phone IS 'Телефон';
/
CREATE TABLE manufacturer_provider
(
    manufacturer_id bigint NOT NULL,
    provider_id     bigint NOT NULL,
    CONSTRAINT manufacturer_provider_pkey PRIMARY KEY (manufacturer_id, provider_id),
    CONSTRAINT manufacturer_id_fkey FOREIGN KEY (manufacturer_id) REFERENCES manufacturer (id),
    CONSTRAINT provider_id_fkey FOREIGN KEY (provider_id) REFERENCES provider (id)
);

CREATE INDEX manufacturer_id_idx ON manufacturer_provider
    (
     manufacturer_id
        );

CREATE INDEX provider_id_idx ON manufacturer_provider
    (
     provider_id
        );

COMMENT
ON TABLE  manufacturer_provider IS 'Производитель-поставщик';

COMMENT
ON COLUMN  manufacturer_provider.manufacturer_id IS 'Идентификатор производителя';
COMMENT
ON COLUMN  manufacturer_provider.provider_id IS 'Идентификатор поставщика';
/
CREATE SEQUENCE product_seq
    AS BIGINT
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
/
CREATE TABLE product
(
    id          bigint      NOT NULL DEFAULT nextval('product_seq'),
    name        varchar(50) NOT NULL,
    fk_provider bigint      NOT NULL,
    fk_category bigint      NOT NULL,
    description text        NOT NULL,
    price       int         NOT NULL,
    CONSTRAINT product_pkey PRIMARY KEY (id),
    CONSTRAINT fk_category_fkey FOREIGN KEY (fk_category) REFERENCES category (id),
    CONSTRAINT fk_provider_fkey FOREIGN KEY (fk_provider) REFERENCES provider (id)
);

CREATE INDEX fk_category_idx ON product
    (
     fk_category
        );

CREATE INDEX fk_provider_idx ON product
    (
     fk_provider
        );

COMMENT
ON TABLE product IS 'Товар';

COMMENT
ON COLUMN product.id IS 'Идентификатор';
COMMENT
ON COLUMN product.name IS 'Название';
COMMENT
ON COLUMN product.fk_provider IS 'Внешний ключ поставщика';
COMMENT
ON COLUMN product.fk_category IS 'Внешний ключ категории';
COMMENT
ON COLUMN product.description IS 'Описание';
COMMENT
ON COLUMN product.price IS 'Цена';
/
CREATE SEQUENCE order_seq
    AS BIGINT
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
/
CREATE TABLE "order"
(
    id         bigint      NOT NULL DEFAULT nextval('order_seq'),
    fk_client  bigint      NOT NULL,
    fk_product bigint      NOT NULL,
    "state"    varchar(50) NOT NULL,
    "date"     timestamp   NOT NULL,
    CONSTRAINT order_pkey PRIMARY KEY (id),
    CONSTRAINT fk_client_fkey FOREIGN KEY (fk_client) REFERENCES client (id),
    CONSTRAINT fk_product_fkey FOREIGN KEY (fk_product) REFERENCES product (id)
);

CREATE INDEX fk_client_idx ON "order"
    (
     fk_client
        );

CREATE INDEX fk_product_idx ON "order"
    (
     fk_product
        );

COMMENT ON TABLE "order" IS 'Заказ';

COMMENT ON COLUMN "order".id IS 'Идентификатор';
COMMENT ON COLUMN "order".fk_client IS 'Внешний ключ клиента';
COMMENT ON COLUMN "order".fk_product IS 'Внешний ключ товара';
COMMENT ON COLUMN "order"."state" IS 'Статус заказа';
COMMENT ON COLUMN "order"."date" IS 'Время заказа';
/
CREATE TABLE product_parameter
(
    parameter_id bigint NOT NULL,
    product_id    bigint NOT NULL,
    value         varchar(50) NOT NULL,
    CONSTRAINT product_parameter_pkey PRIMARY KEY ( parameter_id, product_id ),
    CONSTRAINT parameter_id_fkey FOREIGN KEY ( parameter_id ) REFERENCES parameter ( id ),
    CONSTRAINT product_id_fkey FOREIGN KEY ( product_id ) REFERENCES product ( id )
);

CREATE INDEX parameter_id_idx ON product_parameter
    (
     parameter_id
        );

CREATE INDEX product_id_idx ON product_parameter
    (
     product_id
        );

COMMENT ON TABLE product_parameter IS 'Товар-параметер';

COMMENT ON COLUMN product_parameter.parameter_id IS 'Идентификатор параметра';
COMMENT ON COLUMN product_parameter.product_id IS 'Идентификатор товара';
COMMENT ON COLUMN product_parameter.value IS 'Значение параметра товара';
--rollback drop sequence parameter_seq cascade;
--rollback drop sequence client_seq cascade;
--rollback drop sequence category_seq cascade;
--rollback drop sequence manufacturer_seq cascade;
--rollback drop sequence provider_seq cascade;
--rollback drop sequence product_seq cascade;
--rollback drop sequence order_seq cascade;
--rollback drop table manufacturer_provider cascade;
--rollback drop table manufacturer cascade;
--rollback drop table "order" cascade;
--rollback drop table client cascade;
--rollback drop table product_parameter cascade;
--rollback drop table parameter cascade;
--rollback drop table product cascade;
--rollback drop table category cascade;
--rollback drop table provider cascade;

-- changeset snegov-ds:2 endDelimiter:/
CREATE INDEX client_email_idx ON client (email);
COMMENT ON INDEX client_email_idx IS 'Получение данных клиента по электронной почте';
/
CREATE INDEX client_phone_idx ON client(phone);
COMMENT ON INDEX client_phone_idx IS 'Получение данных клиента по номеру телефона';
/
CREATE INDEX order_by_client_product_idx ON "order" (fk_product, fk_client);
COMMENT ON INDEX order_by_client_product_idx IS 'Получение данных о заказе по fk клиента и товара';
/
CREATE INDEX product_by_category_idx ON product (fk_category);
COMMENT ON INDEX product_by_category_idx IS 'Получение данных о товаре по категории';
/
CREATE INDEX product_by_filters_idx ON product (name, fk_category, price);
COMMENT ON INDEX product_by_filters_idx IS 'Получение данных о товаре по основным фильтрам';
/
CREATE INDEX product_parameter_by_ids_idx ON product_parameter(parameter_id, product_id);
COMMENT ON INDEX product_parameter_by_ids_idx IS 'Получение значения параметра товара по id параметра и товара';
/
ALTER TABLE client ALTER COLUMN first_name SET NOT NULL;
ALTER TABLE client ALTER COLUMN last_name SET NOT NULL;
ALTER TABLE client ALTER COLUMN email SET NOT NULL;
ALTER TABLE client ALTER COLUMN phone SET NOT NULL;
ALTER TABLE client
    ADD CONSTRAINT phone_pattern_chk CHECK (regexp_match(phone, '^\+\d{11}$') IS NOT NULL);
ALTER TABLE client
    ADD CONSTRAINT email_pattern_chk CHECK (email LIKE '%@%');
ALTER TABLE client
    ADD CONSTRAINT unique_client_email UNIQUE (email);
ALTER TABLE client
    ADD CONSTRAINT unique_client_phone UNIQUE (phone);
ALTER TABLE client
    ADD CONSTRAINT age_chk CHECK (date_part('year', age(current_date, birth_date)) > 18 AND
                                  date_part('year', age(current_date, birth_date)) < 120);
/
ALTER TABLE manufacturer ALTER COLUMN name SET NOT NULL;
ALTER TABLE manufacturer ALTER COLUMN address SET NOT NULL;
ALTER TABLE manufacturer ALTER COLUMN phone SET NOT NULL;
ALTER TABLE manufacturer
    ADD CONSTRAINT unique_manufacturer_name UNIQUE (name);
ALTER TABLE manufacturer
    ADD CONSTRAINT unique_manufacturer_phone UNIQUE (phone);
ALTER TABLE manufacturer
    ADD CONSTRAINT unique_link_url UNIQUE (link_url);
/
ALTER TABLE category ALTER COLUMN name SET NOT NULL;
ALTER TABLE category
    ADD CONSTRAINT unique_category_name UNIQUE (name);
/
ALTER TABLE parameter ALTER COLUMN name SET NOT NULL;
ALTER TABLE parameter
    ADD CONSTRAINT unique_parameter_name UNIQUE (name);
/
ALTER TABLE "order" ALTER COLUMN state SET NOT NULL;
ALTER TABLE "order" ALTER COLUMN date SET NOT NULL;
/
ALTER TABLE provider ALTER COLUMN name SET NOT NULL;
ALTER TABLE provider
    ADD CONSTRAINT unique_provider_name UNIQUE (name);
ALTER TABLE provider ALTER COLUMN email SET NOT NULL;
ALTER TABLE provider
    ADD CONSTRAINT unique_provider_email UNIQUE (email);
ALTER TABLE provider
    ADD CONSTRAINT email_pattern_chk CHECK (email LIKE '%@%');
ALTER TABLE provider ALTER COLUMN address SET NOT NULL;
ALTER TABLE provider ALTER COLUMN phone SET NOT NULL;
ALTER TABLE provider
    ADD CONSTRAINT unique_provider_phone UNIQUE (phone);
ALTER TABLE provider
    ADD CONSTRAINT phone_pattern_chk CHECK (regexp_match(phone, '^\+\d{11}$') IS NOT NULL);
ALTER TABLE product
    ADD CONSTRAINT price_product_gt_zero_chk CHECK (price > 0);
--rollback drop index client_email_idx;
--rollback drop index client_phone_idx;
--rollback drop index order_by_client_product_idx;
--rollback drop index product_by_category_idx;
--rollback drop index product_by_filters_idx;
--rollback drop index product_parameter_by_ids_idx;
