# Проектирование БД V2
## Схема
![](src/main/resources/images/erd_v2.png)

## Изменения
Все изменения находятся в changeset snegov-ds:3
- Были оптимизированы типы данных
- Изменено название таблицы "order" на "purchase_order" из-за того, что order является ключевым словом в SQL
- Добавлены таблицы:
    1) client_history (для логирования старых данных клиента. туда данные добавляются через триггер)
    2) price_list (отображение цен на конкретный период времени для конкретного товара)
    3) order_line (возможность добавлять в заказ сразу несколько товаров с разным количеством)
- Для поля purchase_order.state создан enum со списком статусов у заказа

# Установка СУБД PostgreSQL
Добавлен файл docker-compose.yml, с помощью которого мы запускаем контейнер с бд Postgres и системой контроля версий Liquibase.
После успешного запуска Postgres запускается контейнер с Liquibase, который будет загружать в пустую бд наши таблицы

Запуск docker-compose.yml файла вызывается командой:
```
docker-compose up
```
## Пример выполнения команды
![](src/main/resources/images/docker_compose/docker_compose_up.png)
Так же в этом yaml файле все значения настроек вынесены в .env файл
То есть ${POSTGRES_USER} будет заменен на значение из .env файла

## Логи контейнера Postgres
![](src/main/resources/images/docker_compose/postgres_container_log.png)

## Логи контейнера Liquibase
![](src/main/resources/images/docker_compose/liquibase_container_log.png)