[На главную](../../README.MD)

# Добавление индексов и ограничений
В old_changelog_V1.sql в changeset "snegov-ds:2" были добавлены индексы, для наиболее частых будущих запросов к БД.
Каждый индекс так же имеет описание через команду
```postgresql
COMMENT ON INDEX index_name IS 'comment'
```

Были добавлены следующие ограничения:

1)Ограничение на запрет пустых значений (NOT NULL)
```postgresql
ALTER TABLE table_name ALTER COLUMN column_name SET NOT NULL;
```

2)Ограничение на уникальность значения UNIQUE
```postgresql
ALTER TABLE table_name
    ADD CONSTRAINT constraint_name UNIQUE (column_name);
```

3)Ограничение по условию (CHECK)
```postgresql
ALTER TABLE table_name
    ADD CONSTRAINT constraint_check_name CHECK (condition = true);
```