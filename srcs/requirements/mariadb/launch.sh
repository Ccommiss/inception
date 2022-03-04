mysqld&
until mysqladmin ping; do
	sleep 2
	echo "(fail to ping)"
done
cd /root/

## CREE UN USER ADMIN */

mariadb -e "CREATE USER '$MYSQL_ROOT_USER'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'"
mariadb -e "GRANT ALL PRIVILEGES ON * . * TO '$MYSQL_ROOT_USER'@'%'"
mariadb -e "FLUSH PRIVILEGES"
mariadb -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE"

## CREE UN USER PAS ADMIN */

mariadb -e "CREATE USER '$MYSQL_RANDOM_USER'@'mariadb'"
mariadb -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE . * TO '$MYSQL_RANDOM_USER'@'mariadb'"
mariadb -e "FLUSH PRIVILEGES"
killall mysqld
mysqld 
