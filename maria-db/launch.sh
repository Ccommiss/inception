mysqld&
until mysqladmin ping; do
	sleep 2
done
cd /var/www/html/ && mariadb -e "source wp-launch.sql"
killall mysqld
mysqld