FROM	debian:buster
RUN		apt-get update -y
RUN		apt-get install -y nginx
COPY	./nginx.conf /etc/nginx/
COPY	./index.php /var/www/html/

#la ou y a les fichiers conf
COPY  	./index.html /var/www/html/
#COPY	./index.nginx-debian.html /var/www/html/ #ca casse tout si je modifie ....... alors que meme filename
CMD		["nginx", "-g", "daemon off;"]
#CMD		bash /var/launch.sh


# ca fonctionne de mettre hello world dans /usr/share/nginx/html/ mais que auqnd je suis en it mode
# https://stackoverflow.com/questions/50705838/docker-compose-with-nginx-keeps-displaying-welcome-page
#https://www.nginx.com/blog/deploying-nginx-nginx-plus-docker/
