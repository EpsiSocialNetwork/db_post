FROM postgres:13

COPY ddl_posthoop_post.sql .
COPY dml_posthoop_post.sql .

RUN cat ddl_posthoop_post.sql > /docker-entrypoint-initdb.d/init.sql
RUN cat dml_posthoop_post.sql >> /docker-entrypoint-initdb.d/init.sql

EXPOSE 5432