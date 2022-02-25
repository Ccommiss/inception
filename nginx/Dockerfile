FROM	debian:buster
RUN		apt-get update -y
RUN		apt-get install -y nginx
COPY	./default.conf /etc/nginx/conf.d/	
#COPY	./index.nginx-debian.html /usr/share/nginx/html/	 
COPY	./index.html /usr/share/nginx/html/	 
 # au dessus ca plante si je fais ca, alrs que sinon affiche nginx normal a index.html ; ligne suivant : ca change a index.html mais tjrs page accueil nginx comme si je pouvais pas la remplacer
#COPY	./default /etc/nginx/sites-enabled/
#COPY	./index.nginx-debian.html /var/www/html/ #ca casse tout si je modifie ....... alors que meme filename
#RUN     rm -rf /var/www/html/index.nginx-debian.html
CMD		["nginx", "-g", "daemon off;"]
#CMD		bash /var/launch.sh


# ca fonctionne de mettre hello world dans /usr/share/nginx/html/ mais que auqnd je suis en it mode 
# https://stackoverflow.com/questions/50705838/docker-compose-with-nginx-keeps-displaying-welcome-page
#https://www.nginx.com/blog/deploying-nginx-nginx-plus-docker/