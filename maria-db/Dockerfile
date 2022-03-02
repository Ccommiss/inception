FROM	debian:buster
RUN		apt-get update -y
RUN 	apt-get autoclean
RUN		apt-get install -y mariadb-server
RUN 	apt-get install -y mariadb-client
COPY	./50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN 	mkdir -p /var/run/mysqld/
RUN		mkdir -p /run/mysqld/ && chown -R mysql:root /run/mysqld
#RUN 	service mysql start
COPY 	./wp-launch.sql /var/www/html/
# va creer la database sur laquelle s'appuiera WP plus tard
COPY 	./launch.sh /var/
CMD 	["bash", "/var/launch.sh"]
#RUN		mysql_secure_installation



