-- Индексы PostgreSQL
-- Цель:
-- Знать и уметь применять основные виды индексов PostgreSQL
-- Построить и анализировать план выполнения запроса
-- Уметь оптимизировать запросы для с использованием индексов
--
-- Описание/Пошаговая инструкция выполнения домашнего задания:
-- Создать индексы на БД, которые ускорят доступ к данным.
-- В данном задании тренируются навыки:
--
-- определения узких мест
-- написания запросов для создания индекса
-- оптимизации
-- Необходимо:
-- Создать индекс к какой-либо из таблиц вашей БД
-- Прислать текстом результат команды explain,
--     в которой используется данный индекс
--     Реализовать индекс для полнотекстового поиска
--     Реализовать индекс на часть таблицы или индекс
--     на поле с функцией
--     Создать индекс на несколько полей
--     Написать комментарии к каждому из индексов
--     Описать что и как делали и с какими проблемами
--     столкнулись

-- Создаем 30000 записей поставщиков
INSERT INTO provider (name, email, address, phone)
select
        'provider_' || random()::text,
        'user' || gen_random_uuid() || '@mail.ru',
        'http://qwerty.ru',
        '+' || floor(random() * (70000001000 - 70000000000 + 1)) + 70000000000 FROM generate_series(1, 30000);

-- БЕЗ ИНДЕКСА:
-- Seq Scan on provider  (cost=0.00..893.00 rows=29 width=111)
--   Filter: ((phone)::text = '+70000000390'::text)
explain SELECT * FROM provider WHERE phone = '+70000000390';

-- Создаем индекс для этого запроса
CREATE INDEX provider_phone_idx ON provider USING btree (phone);

-- С ИНДЕКСОМ:
-- Bitmap Heap Scan on provider  (cost=4.51..100.29 rows=29 width=111)
--   Recheck Cond: ((phone)::text = '+70000000390'::text)
--   ->  Bitmap Index Scan on provider_phone_idx  (cost=0.00..4.50 rows=29 width=0)
--         Index Cond: ((phone)::text = '+70000000390'::text)
explain SELECT * FROM provider WHERE phone = '+70000000390';


-- Полнотекстовый поиск БЕЗ ИНДЕКСА
-- Seq Scan on provider  (cost=0.00..15893.00 rows=150 width=111)
--   Filter: (to_tsvector('english'::regconfig, address) @@ to_tsquery('qwerty.ru'::text))
explain SELECT * FROM provider
WHERE to_tsvector('english', address) @@ to_tsquery('qwerty.ru');

-- Для ускрорения текстовог поиска создаем индекс GIN
CREATE INDEX provider_address_gin_idx ON provider USING gin (to_tsvector('english', address));

-- Полнотекстовый поиск С ИНДЕКСОМ
-- Bitmap Heap Scan on provider  (cost=25.41..430.39 rows=150 width=111)
--   Recheck Cond: (to_tsvector('english'::regconfig, address) @@ to_tsquery('qwerty.ru'::text))
--   ->  Bitmap Index Scan on provider_address_gin_idx  (cost=0.00..25.38 rows=150 width=0)
--         Index Cond: (to_tsvector('english'::regconfig, address) @@ to_tsquery('qwerty.ru'::text))
explain SELECT * FROM provider
        WHERE to_tsvector('english', address) @@ to_tsquery('qwerty.ru');


-- Реализовать индекс на часть таблицы или индекс на поле с функцией
DROP INDEX provider_phone_idx;
CREATE INDEX provider_phone_where_idx ON provider(phone)
    WHERE NOT phone = '+70000000778';

-- НЕ ПОЛУЧАЕТСЯ ПРИМЕНИТЬ ЭТОТ ИНДЕКС
-- Seq Scan on provider  (cost=0.00..893.00 rows=29971 width=111)
--   Filter: ((phone)::text <> '+70000000778'::text)
explain SELECT * FROM provider
WHERE NOT phone = '+70000000778';


-- Создать индекс на несколько полей
CREATE INDEX provider_address_phone_idx ON provider(address, phone);

-- Index Scan using provider_address_phone_idx on provider  (cost=0.29..6.06 rows=1 width=111)
--   Index Cond: ((address = 'new_address'::text) AND ((phone)::text = '+70000000778'::text))
explain SELECT * FROM provider
WHERE address = 'new_address' AND phone = '+70000000778';

-- Вывод: Сравнивая по скорости выполнения 'Seq Scan' и 'Index Scan', то в большинстве случаев быстрее по выполнению будет Index Scan.
-- Но опять же нужно все тестировать на конкретных данных