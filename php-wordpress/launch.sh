cd /var/www/html
wp core download --allow-root
mv /etc/wp-config.php . #on bouge
chmod o+r wp-config.php
#o = pour others  
echo $MYSQL_ROOT_PASSWORD $MYSQL_ROOT_USER
until mysqladmin -hmaria-db -u${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} ping && mariadb -hmaria-db -u${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} -e "SHOW DATABASES;" | grep ${MYSQL_DATABASE}; do
	sleep 2
done
echo "SQL ADMIN REACHED"
#db create va se servir des infos de wp-config pour faore ;les tables etc
#wp db create --allow-root
wp core install --url="ccommiss.42.fr" --title="Mon site web @ccommiss" --admin_user="${MYSQL_ROOT_USER}" --admin_password="${MYSQL_ROOT_PASSWORD}" --admin_email="lol@lol.fr" --skip-email --allow-root
wp user create bob bob@example.com --role=author --user_pass="bob" --allow-root

php-fpm7.3 -F -R
root