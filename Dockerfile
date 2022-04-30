FROM mysql/mysql-server:latest
ENV MYSQL_ROOT_PASSWORD=rootroot
ADD ./scripts/clinic.sql /docker-entrypoint-initdb.d
EXPOSE 3306