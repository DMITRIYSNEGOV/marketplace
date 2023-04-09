-- 1. Напишите запрос по своей базе с регулярным выражением, добавьте пояснение, что вы хотите найти.
-- Посмотреть поставщиков, у которых производители начинаются с "ООО"

-- Подготавливаем данные Производителя
INSERT INTO manufacturer (name, address, working_days_mode, phone, link_url, description, working_time_mode)
VALUES ('ООО Рога и копыта', 'Москва Ленина 1', 'пн-пт', '+79991234567', 'http://megaurl.com', 'производство мебели',
        '09:00-18:00');
INSERT INTO manufacturer (name, address, working_days_mode, phone, link_url, description, working_time_mode)
VALUES ('ООО Artemis', 'Москва Ленина 2', 'пн-пт', '+79991234568', 'http://megaurl1.com', 'производство мебели',
        '09:00-18:00');
INSERT INTO manufacturer (name, address, working_days_mode, phone, link_url, description, working_time_mode)
VALUES ('ПАО Финанс', 'Москва Ленина 3', 'пн-пт', '+79991234569', 'http://megaurl2.com', 'производство мебели',
        '09:00-18:00');
INSERT INTO manufacturer (name, address, working_days_mode, phone, link_url, description, working_time_mode)
VALUES ('ПАО Тревел', 'Москва Ленина 4', 'пн-пт', '+79991234560', 'http://megaurl3.com', 'производство мебели',
        '09:00-18:00');

-- Подготавливаем данные Поставщика
INSERT INTO provider (name, email, address, phone)
VALUES ('Быстров', 'bistro@mail.ru', 'Саммера 1', '+71112223344');
INSERT INTO provider (name, email, address, phone)
VALUES ('Логистиков', 'logic@mail.ru', 'Саммера 2', '+71112223345');
INSERT INTO provider (name, email, address, phone)
VALUES ('Доставщиков', 'delivery@mail.ru', 'Саммера 3', '+71112223346');
INSERT INTO provider (name, email, address, phone)
VALUES ('Оперативнов', 'fast@mail.ru', 'Саммера 4', '+71112223347');
INSERT INTO provider (name, email, address, phone)
VALUES ('Оптов', 'optov@mail.ru', 'Саммера 5', '+71112223348');

-- Связываем Производителя и Поставщика
INSERT INTO manufacturer_provider (manufacturer_id, provider_id) VALUES (1, 1);
INSERT INTO manufacturer_provider (manufacturer_id, provider_id) VALUES (1, 2);
INSERT INTO manufacturer_provider (manufacturer_id, provider_id) VALUES (2, 4);
INSERT INTO manufacturer_provider (manufacturer_id, provider_id) VALUES (3, 4);

-- Сам запрос
SELECT p.id id_p, p.name p_name, m.id id_m, m.name m_name
FROM provider p
INNER JOIN manufacturer_provider mp
    ON p.id = mp.provider_id
INNER JOIN manufacturer m
    ON mp.manufacturer_id = m.id
WHERE m.name LIKE 'ООО%';



-- 2. Напишите запрос по своей базе с использованием LEFT JOIN и INNER JOIN, как порядок соединений в FROM влияет на результат? Почему?
SELECT p.id id_p, p.name p_name, m.id id_m, m.name m_name
FROM provider p
         LEFT JOIN manufacturer_provider mp
                    ON p.id = mp.provider_id
         LEFT JOIN manufacturer m
                    ON mp.manufacturer_id = m.id;

-- Меняем местами
SELECT p.id id_p, p.name p_name, m.id id_m, m.name m_name
FROM manufacturer m
         LEFT JOIN manufacturer_provider mp
                   ON m.id = mp.manufacturer_id
         LEFT JOIN provider p
                   ON mp.provider_id = p.id;

-- Понимаем, что данные таблицы, которая пишется сначала в LEFT JOIN
-- будет иметь данные в выборке даже если условия не выполняются в ON блоке,
-- а данные из другой таблицы будут null



-- 3. Напишите запрос на добавление данных с выводом информации о добавленных строках.
-- Добавим запись Производитель и выведем id, который генерируется с помощью последовательности. Очень полезно для backend разработки
INSERT INTO manufacturer (name, address, working_days_mode, phone, link_url, description, working_time_mode) VALUES
('Новый производитель', 'Ленина 10', 'пн-вт', '+79991234588', 'http://newmanufacturer.com', 'производство деталей машины', '00:00-00:00')
returning id;




-- 4. Напишите запрос с обновлением данные используя UPDATE FROM.
-- Добавить к каждому адресу поставщика адрес производителя, у которых одинаковый ID
UPDATE provider p SET address = (p.address || ' + ' || m.address)
FROM manufacturer m WHERE m.id = p.id;



-- 5.Напишите запрос для удаления данных с оператором DELETE используя join с другой таблицей с помощью using.
-- Удалить все связи поставщика производителя, где у производителя имя начинается с ООО
DELETE FROM manufacturer_provider mp
    USING manufacturer m
    WHERE mp.manufacturer_id = m.id AND m.name LIKE 'ООО%';