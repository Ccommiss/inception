cd /var/www/html
wp core download --allow-root

until mysqladmin -hmaria-db -uwordpress -pwordpress ping; do
	sleep 2
done
#db create va se servir des infos de wp-config pour faore ;les tables etc 
#wp db create --allow-root
wp core install --url="localhost" --title="ta mere" --admin_user="wordpress" --admin_password="wordpress" --admin_email="lol@lol.fr" --skip-email --allow-root
#wp core install --url=http://siteurl.com --title=SiteTitle --admin_user=username --admin_password=mypassword --admin_email=my@email.com

php-fpm7.3 -F -R