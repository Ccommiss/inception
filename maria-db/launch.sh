mysqld&
until mysqladmin ping; do
	sleep 2
	echo "(fail to ping)"
done
cd /root/ && mariadb -e "source wp-launch.sql"
killall mysqld
mysqld
