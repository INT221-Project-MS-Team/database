FROM mysql/mysql-server:latest
ENV MYSQL_ROOT_PASSWORD=%kBLfS@XZfQ_@p7JHq*+X+bCdvdSw^
ADD ./scripts/clinic.sql /docker-entrypoint-initdb.d
EXPOSE 3306