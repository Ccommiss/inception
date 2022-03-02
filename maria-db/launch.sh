mysqld&
until mysqladmin ping; do
	sleep 2
	echo "(fail to ping)"
done
cd /root/ && mariadb -e "source wp-launch.sql"
sleep 3
echo pouet
killall mysqld
mysqld
