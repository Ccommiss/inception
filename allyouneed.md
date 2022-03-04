# Inception

One Paragraph of project description goes here

## Getting Started

Tous les credits de ces instructions au plus gros crack de la galaxie. Même si citer Son nom est superflu, car tout le monde le connaît, on le citerqa pour les moldus : le grand Arthur Trouillet. Mr Courgettos pour les plus intimes.

### Summary

- [Inception](#inception)
  - [Getting Started](#getting-started)
    - [Summary](#summary)
    - [Petit apercu de Docker](#petit-apercu-de-docker)
  - [Part 1 : NGINX](#part-1--nginx)
        - [Nginx hierarchy](#nginx-hierarchy)
      - [La directive *```listen```*](#la-directive-listen)
      - [La directive *```root```*](#la-directive-root)
      - [La directive *```location```*](#la-directive-location)
  - [Part 2 : PHP-fpm](#part-2--php-fpm)
        - [Dans le container NGINX](#dans-le-container-nginx)
        - [Dans le container PHP-FPM](#dans-le-container-php-fpm)
  - [Part 3 : Wordpress et MariaDB](#part-3--wordpress-et-mariadb)
      - [Maria DB et Wordpress : vue d'ensemble et interactions](#maria-db-et-wordpress--vue-densemble-et-interactions)
      - [Maria DB](#maria-db)
        - [Comment faire communiquer Maria DB et le reste ?](#comment-faire-communiquer-maria-db-et-le-reste-)
      - [Wordpress](#wordpress)
    - [Outilllage Docker](#outilllage-docker)
      - [Docker volumes : partager des fichiers locaux entre nos containeurs](#docker-volumes--partager-des-fichiers-locaux-entre-nos-containeurs)
      - [Docker network : faire communiquer nos containeurs entre eux avec leur nom de service](#docker-network--faire-communiquer-nos-containeurs-entre-eux-avec-leur-nom-de-service)


### Petit apercu de Docker 

<img src="https://miro.medium.com/max/1400/1*4ggdo8ZeFqae_j9r09fPNA.png"
     alt="Markdown Monster icon" />

## Part 1 : NGINX
_________

NGINX est un serveur web. C'est elle qui va **servir les pages web**, interpréter le HTML, etc. C'est lui qui va processer les requêtes du protocole  HTTP.

Par convention, NGINX écoute sur le port 80 pour le protocole http. Le protocole https écoute, par convention également, sur le port 443.

<img src="https://miro.medium.com/max/1276/0*m_Rey9rU_HIi674J.jpg"
     alt="Markdown Monster icon" />

Écouter, ça veut dire quoi ?
Quand on fait une requête, elle est envoyée depuis une adresse IP et un port. NGINX va chercker si ca matche sa directive listen, écrite comme telle :

[Plus d'infos](http://nginx.org/en/docs/http/request_processing.html)

##### Nginx hierarchy

Comment s'y retrouver dans les fichiers de configuration NGINX ?
En gros :

- Un fichier indispensable : le nginx.conf, à placer dans /etc/nginx.
 Pour le projet qui nous intéresse, on aura besoin que de lui.
- D'autres fichiers de conf, dans le dossier /etc/nginx/conf.d, à inclure qvec une directive include dans le fichier nginx.conf. Une bonne pratique peut être de diviser les blocs de directives selon les services, et avoir dans ce sous dossier un mail.conf, serviceenacronyme.conf, etc.

<https://docs.nginx.com/nginx/admin-guide/basic-functionality/managing-configuration-files/>

#### La directive *```listen```*

```
server {
    listen ADDRESS:PORT (server_name);
}
```

La plupart du temps, on ne spécifie que le port : 80, 443 ...
L'adresse IP est implicite : cela donne en réalité 0.0.0.0:80 par exemple. Cela signifie "toutes les adresses IP, sur le port 80".

Si on ne spécifie pas le port non plus, c'est pqr défaut le port 80 qui est utilisé.

Si la même adresse IP correspond à plusieur serveurs web, c'est la que le champ server name est intéressant. Dans le header de la requête HTTP, il y a un champs "Host" qui renferme potentiellement le nom du serveur, que NGINX va donc essayer de matcher.

*Mais pourquoi ca doit pouvoir venir de tout le monde ? 127.0.0.1, le localhost, ça suffit non ?*
Ici, non : on se rappelle que dans docker, chaque service est sa propre petite machine. Si NGINX écoutait sur 127.0.0.1, il s'écouterait lui-même — et on ne veut pas que NGINX soit un mec cis-het.

#### La directive *```root```*

Ok on écoute des ports, mais les fichiers de ma page web, ils sortent d'où ?

On le spécifie à l'aide d'un mot root, qui va spécifier dans quel dossier du serveur se trouvent les fichiers qu'on peut aller demander.

Par exemple, si tous les fichiers .html de votre skyblog se trouvent dans /var/www/monskyblog, et bien root resssemblera à :

```root /var/www/monskyblog```

Eh bien tous les fichiers qu'on pourra servir seront ceux placés dans ce répertoire.

Cette directive est à placer dans le bloc serveur ; mais on peut en replacer d'autres dans d'autres blocs.

[Plus d'infos](https://docs.nginx.com/nginx/admin-guide/web-server/web-server/)

#### La directive *```location```*

Dans le bloc serveur, on trouve plusieurs directiuves "location".
Les locations vont spécifier les comportements à adopter pour servir certains fichiers. Ces *locations* peuvent être définies :

- Par des paths : ```location /some/path/```
 Par exemple, si je veux acceder à la page monsite.fr/some/path/index.html, on tombera dans ce bloc.
- Par des regex : ```location ~ \.php?```
 Si vous n'avez pas inventé l'eau chaude : on tombe ici pour les requêtes de pages PHP qui ne correspondent pas à un chemin précis.

## Part 2 : PHP-fpm
_________

Ne vous en faites pas, on en a pas totalement fini avec NGINX.

Un petit indice dans le titre : FPM signifie FastCGI Parameter Manager. Il a été inventé spécialement pour fonctionner avec NGINX.
FastCGI : c'est un protocole.

##### Dans le container NGINX

En gros, NGINX ne peut pas gérer le PHP tout seul. Lui il affiche du HTML, mais pour le PHP, il lui faut une sorte d'interprète. C'est là qu'en plus d'être un serveur web, on découvre une autre fonctionnalité de NGINX : le proxy.

NGINX va forwarder les requêtes qu'il ne peut pas processer à PHP-FPM.
On peut lire dans la [la sainte doc](https://www.digitalocean.com/community/tutorials/understanding-and-implementing-fastcgi-proxying-in-nginx)

``` fastcgi_pass: ``` The actual directive that passes requests in the current context to the backend. This defines the location where the FastCGI processor can be reached.

<https://www.digitalocean.com/community/tutorials/>

how-to-set-up-laravel-nginx-and-mysql-with-docker-compose#step-5-configuring-php
In the php location block, the fastcgi_pass directive specifies that the app service is listening on a TCP socket on port 9000. This makes the PHP-FPM server listen over the network rather than on a Unix socket. Though a Unix socket has a slight advantage in speed over a TCP socket, it does not have a network protocol and thus skips the network stack. For cases where hosts are located on one machine, a Unix socket may make sense, but in cases where you have services running on different hosts, a TCP socket offers the advantage of allowing you to connect to distributed services. Because our app container is running on a different host from our webserver container, a TCP socket makes the most sense for our configuration.

Voila.

```
location ~ \.php$ {
    fastcgi_pass <Addresse Ip du truc qui sait lire php>:<port de la config du truc qui sait lire du PHP>;
}
```

Ici on a deux solutions :

- Soit on met une IP statique à un conteneur docker de php, imaginons 178.123.123.123.
On met 178.123.123.123:9000. OK mais giga relou.
- Réussir à communiquer directement via le nom de notre service. Ce serait vachement pratique ; pour ping mon container dont le nom de service est monphpfpm, il suffirait de faire monphpfpm:<port concerné>.

Eh bien...... C'est possible grâce qu docker network, en bridge ! On le verra plus loin.
Pour l'instant partons du principe que vous pouvez ecrire : [nom du service tel que dans docker]:9000;

##### Dans le container PHP-FPM

Dans le fichier /etc/php/7.3/fpm/pool.d/www.conf : on trouve le fichier de configuration de fpm.
Il va falloir aussi le modifier.

On retrouve ici cette directive qui parle de FastCGI : comme on l'a dit plus haut et deja modifie dans NGINX, on passe d'une ecoute sur un socket unix, a une ecoute sur un port, pour accespter les requetes venant de nos autres conteneurs et de toutes les addresses.

>; The address on which to accept FastCGI requests.
; Valid syntaxes are:
;   'ip.add.re.ss:port'    - to listen on a TCP socket to a specific IPv4 address on
;                            a specific port;
;   '[ip:6:addr:ess]:port' - to listen on a TCP socket to a specific IPv6 address on
;                            a specific port;
;   'port'                 - to listen on a TCP socket to all addresses
;                            (IPv6 and IPv4-mapped) on a specific port;
;   '/path/to/unix/socket' - to listen on a unix socket.
; Note: This value is mandatory.
**listen = 9000**

Voila ! C'est tout.

## Part 3 : Wordpress et MariaDB
_________


#### Maria DB et Wordpress : vue d'ensemble et interactions

Maria DB est un systeme de gestion de base de donnees qui repose sur MySQL. Comme le projet diont il est issu donc, on communique avec Maria DB via le langage SQL.

Wordpress compte sur MySQL (ou MariaDB, ou InnoDB...) pour pouvoir fonctionner. En effet, une partie importante de Wordpress va reposer sur le fait d'avoir des tables qui vont contenir les commentaires, les posts...

Des exemples de tables creees a la creation de WP :

>wp_commentmeta
wp_comments
wp_links
wp_options
wp_postmeta

<https://kinsta.com/knowledgebase/wordpress-database/>

Pour etre cree, Wordpress a besoin qu'une base de donnees soit deja creee, et qu'on lui dise de l'utiliser.
les informations de base vont se trouver dans un fichier wp-config.php, qui contiendra par exemple :

```
// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wp_wordpress' );

/** MySQL database username */
define( 'DB_USER', 'wordpress' );

/** MySQL database password */
define( 'DB_PASSWORD', 'wordpress' );

/** MySQL hostname */
define( 'DB_HOST', 'maria-db' );
```

#### Maria DB 


Il faudra donc creer a minima tout cela dans un script MySQL, lance dans le conteneur de MariaDB. Sans cela, Wordpress ne pourra pas se configurer : on a besoin de ca. 

Un script tres simple : 

```
CREATE USER 'wordpress'@'%' IDENTIFIED BY 'wordpress';
GRANT ALL PRIVILEGES ON * . * TO 'wordpress'@'%';
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS wp_wordpress;
```

Pour lancer le service MariaDB, on se sert de la commande : mysqld. 
C'est ecrit la : https://mariadb.com/kb/en/starting-and-stopping-mariadb-automatically/ 

Une autre commande tres pratique pour checker des choses en rapport avec comment va MySQL : [mysqladmin.](https://dev.mysql.com/doc/refman/8.0/en/mysqladmin.html)


Nb: On s'en servira egalement depuis Wordpress. Pour pouvoir l'utiliser, il faut installer la package ``` mariadb-client ``` : on est cote client, et plus cote serveur/.

##### Comment faire communiquer Maria DB et le reste ?

De la meme maniere qu'on a change les parametres de NGINX, Maria DB ne doit plus etre bindee sur 127.0.0.1 mais sur tous les acteurs du reseau.
Il suffit de commenter cette ligne :

> bind-address            = 127.0.0.1

#### Wordpress

Pas beaucoup de malice dans cette partie : il va s'agir d'installer Wordpress et son artillerie de fichiers. 
Petite astuce neanmoins : les containeurs sont lances en meme temps, et la directives "depends_on", qui lance un container avant celui qui en depend, ne garantit pas que toute l'installation sera faite avant.

Un petit morceau de code (toujours par le sublime @arthur-trt) qui permettra a toutes vos etapes de bien se derouler. On utilise donc cette fabuleuse commande [```mysqladmin```](https://dev.mysql.com/doc/refman/8.0/en/mysqladmin.html)

```
until mysqladmin -hmaria-db -uwordpress -pwordpress ping 
    && mariadb -hmaria-db -uwordpress -pwordpress -e "SHOW DATABASES;" | grep "wp_wordpress"; do
	sleep 2
done
```

<span style="color:green;"> Qu'est-ce qu'on fait ici? </span>
On sleep tant qu'on n'arrive pas a se connecter a l'host maria-db (c'est le nom du service donne dans le docker compose), avec l'utilisateur wordpress (cree dans le script de lancement mysql), le mot de passe wordpress ; on execute ensuite dans ce meme service une commande SHOW DATABASES et un grep sur le nom de la table censee etre creee. Ainsi, on s'assure que wp n'essaie pas de se configurer (a l'aide de son fichier wp-config) avant meme que sa base de donnee soit creee.

On peut desormais installer Wordpress.
On a deux options en realite :
- installer avec wp cli
- copier les fichiers sources.


### Outilllage Docker

#### Docker volumes : partager des fichiers locaux entre nos containeurs

Comme nous allons faire des choses dans notre base de données et wordpress, on aimerait que ce soit persistant. Si on ne crée pas de volumes, il faudrait tout recommencer à chaque fois qu'on relance le container...

Syntax: ```/host/path:/container/path```

Nous allons vouloir créer un bind mounts volume. En gros, on va choisir un répertoire courant de notre host, qui va stocker les data de notre container.

```volumes:```
```- $PWD/data:/var/lib/mysql```

<https://towardsdatascience.com/the-complete-guide-to-docker-volumes-1a06051d2cce>

Une chose a savoir pour les volumes :

- Quand on bind un volume avec un dossier, ce qu'il y avait dans le dossier est overwrite.
- Une solution : si il y a absolument des fichiers qu'on a besoin de copier dans pile poil ce repertoire, on fait la manip depuis un script.

#### Docker network : faire communiquer nos containeurs entre eux avec leur nom de service

D'après cette documentation, on lit que Docker daemon (le processus qui s'éxécute en arrière plan) possède un résolveur DNS intégré. Un résolveur DNS, c'est une sorte d'annuaire qui fait correspondre une adresse IP et un nom de domaine. Pour ça que vous pouvez juste retenir "google.fr", et pas quatre blocs de trois chiffres pour poser une question.

> Serveur DNS intégré
>
> Docker daemon exécute un serveur DNS intégré qui fournit **une résolution de noms aux conteneurs connectés au réseau créé par les utilisateurs, de sorte que ces conteneurs peuvent résoudre les noms de d’hôtes en adresses IP**.
>
>Si le serveur DNS intégré est incapable de résoudre la demande, il sera transmis à tous les serveurs DNS externes configurés pour le conteneur. Pour faciliter cela lorsque le conteneur est créé, seul le serveur DNS intégré 127.0.0.11 est renseigné dans le fichier resolv.conf du conteneur.
>
>Source : <https://blog.alphorm.com/reseau-docker-partie-1-bridge/>

Il y a quand même une condition : de base, les conteneurs sont parfaitement isolés, c'est le principe de docker. Docker propose un network par défaut, mais celui-ci ne permet pas aux containeurs de se connecter entre eux. Il nous faut un *user defined* network.

``` docker network inspect __networkname___ ```

<https://stackoverflow.com/questions/31149501/how-to-reach-docker-containers-by-name-instead-of-ip-address>

<https://cloudkul.com/blog/understanding-communication-docker-containers/>

<https://docs.docker.com/network/bridge/>

<https://forums.docker.com/t/how-to-communicate-from-one-php-container-to-another/82475>

<https://www.digitalocean.com/community/tutorials/how-to-set-up-laravel-nginx-and-mysql-with-docker-compose>

Rien de très sorcier en rélaite ; on va seulement créer un neetwork avec le nom aue vous voulez et une spécificitié : driver bridge. Grâce à ça, c'est Docker Engine qui va s'occuper de toute la tambouille de firewalls etc pour configurer le réseau, pour que seuls les gens connectés sur son réseau puissent se connecter.

Voilà un schéma :

<img src="http://img.scoop.it/bmExZyvGWidultcwx9hCb7nTzqrqzN7Y9aBZTaXoQ8Q=">

Selon la documentation :
>The bridge driver creates a private network internal to the host so containers on this network can communicate. External access is granted by exposing ports to containers. Docker secures the network by managing rules that block connectivity between different Docker networks.
>
><https://www.docker.com/blog/understanding-docker-networking-drivers-use-cases/>


volumes 
https://stackoverflow.com/questions/40905761/how-do-i-mount-a-host-directory-as-a-volume-in-docker-compose