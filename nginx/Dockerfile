FROM	debian:buster
RUN		apt-get update -y
RUN		apt-get install -y nginx

COPY	./nginx.conf /etc/nginx/
RUN		ln -sf /dev/stdout /var/log/nginx/access.log \
		&& ln -sf /dev/stderr /var/log/nginx/error.log \
		&& apt-get install openssl \
		&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/C=FR/ST= /L= /O= /CN=localhost"  -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt


CMD		["nginx", "-g", "daemon off;"]
#CMD		bash /var/launch.sh


# ca fonctionne de mettre hello world dans /usr/share/nginx/html/ mais que auqnd je suis en it mode
# https://stackoverflow.com/questions/50705838/docker-compose-with-nginx-keeps-displaying-welcome-page
#https://www.nginx.com/blog/deploying-nginx-nginx-plus-docker/
