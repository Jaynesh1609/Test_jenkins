FROM Ubuntu:latest

#MAINTAINER NewstarCorporation

RUN apt-get install httpd -y

COPY index.html /var/www/html/

CMD [“/usr/sbin/httpd”, “-D”, “FOREGROUND”]

EXPOSE 80
