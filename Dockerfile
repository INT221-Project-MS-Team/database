FROM mysql/mysql-server:latest
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8 
ENV MYSQL_ROOT_PASSWORD=%kBLfS@XZfQ_@p7JHq*+X+bCdvdSw^
ADD ./scripts/clinic.sql /docker-entrypoint-initdb.d
ADD ./config/my.conf /etc/my.cnf
EXPOSE 3306