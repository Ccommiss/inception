/* CREE UN USER ADMIN */

CREATE USER 'wordpress'@'%' IDENTIFIED BY 'wordpress';
GRANT ALL PRIVILEGES ON * . * TO 'wordpress'@'%';
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS wp_wordpress;

/* CREE UN USER PAS ADMIN */

CREATE USER 'user'@'maria-db';
GRANT ALL PRIVILEGES ON wp_wordpress . * TO 'wordpress'@'%';
FLUSH PRIVILEGES;