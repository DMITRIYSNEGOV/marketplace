FROM postgres:14.1

RUN mkdir -p /var/lib/marketplace_data
RUN chown postgres:postgres /var/lib/marketplace_data
RUN mkdir -p /var/lib/marketplace_indexes
RUN chown postgres:postgres /var/lib/marketplace_indexes

COPY ./main/resources/db/init/1_init_db_script.sql /docker-entrypoint-initdb.d/1_init_db_script.sql

