FROM	debian:buster
RUN		apt-get update -y
RUN		apt-get install -y nginx

COPY	./nginx.conf /etc/nginx/
#la ou y a les fichiers conf
COPY  	./index.html /var/www/html/
COPY  	./index.php /var/www/html/
RUN		chmod 755 /var/www/html
RUN		chmod 644 /var/www/html/index.html
RUN		chown -R www-data:www-data /var/www
CMD		["nginx", "-g", "daemon off;"]
#CMD		bash /var/launch.sh


# ca fonctionne de mettre hello world dans /usr/share/nginx/html/ mais que auqnd je suis en it mode
# https://stackoverflow.com/questions/50705838/docker-compose-with-nginx-keeps-displaying-welcome-page
#https://www.nginx.com/blog/deploying-nginx-nginx-plus-docker/
