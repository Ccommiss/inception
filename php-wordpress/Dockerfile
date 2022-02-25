FROM debian:buster
RUN	apt-get update -y
RUN apt-get install -y php php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip
COPY ./index.php /var/www/html/
CMD [ "php", "./index.php" ]