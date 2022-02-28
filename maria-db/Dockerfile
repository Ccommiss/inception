FROM	debian:buster
RUN		apt-get update -y
RUN		apt-get install -y mariadb-server mariadb-client
COPY	./50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf 
RUN 	service mysql start

#RUN		mysql_secure_installation


