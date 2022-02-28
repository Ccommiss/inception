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

RUN 	apt-get install curl

RUN 	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN		chmod +x wp-cli.phar
RUN		mv wp-cli.phar /usr/local/bin/wp
#COPY 	./launch.sh /usr/local/bin/wp/
#RUN 	/usr/local/bin/wp/launch.sh
RUN 	cd /var/www/html/ && wp core download --allow-root
#RUN		wp core config --allow-root --dbname=mydbname --dbuser=mydbuser --dbpass=mydbpass --dbhost=localhost --dbprefix=whebfubwef_ --extra-php <<PHP
		# \ define( 'WP_DEBUG', true );
		# \ define( 'WP_DEBUG_LOG', true );
		# \ PHP
		# \ wp db create

EXPOSE 9000
CMD [ "php-fpm7.3", "-F", "-R" ]
