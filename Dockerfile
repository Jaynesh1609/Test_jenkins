FROM centos:latest

#MAINTAINER NewstarCorporation

RUN sudo yum -y install httpd

COPY index.html /var/www/html/

CMD [“/usr/sbin/httpd”, “-D”, “FOREGROUND”]

EXPOSE 80
