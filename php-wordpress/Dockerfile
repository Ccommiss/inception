FROM debian:buster
RUN	apt-get update -y
RUN apt-get install -y php php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip
COPY ./index.php /var/www/html/
COPY ./www.conf /etc/php/7.3/fpm/pool.d/
RUN 	mkdir -p /var/run/
RUN 	mkdir -p /run/php/
RUN		chmod 755 /var/www/html
RUN		chmod 644 /var/www/html/index.php
RUN		chown -R www-data:www-data /var/www

COPY ./wp-config.php /var/www/html/
COPY ./launch.sh  /var/www/html/

RUN 	apt-get install curl mariadb-client -y
##mariadb-client

RUN 	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN		chmod +x wp-cli.phar
RUN		mv wp-cli.phar /usr/local/bin/wp


#va mettre les username ec
EXPOSE	9000
CMD [ "bash", "/var/www/html/launch.sh" ]
