FROM ubuntu:16.04

LABEL maintainer="B.E.A.R. <bcakir@beartell.com>"

RUN apt-get update --fix-missing

# Install Apache
RUN apt-get --fix-missing -y install apache2 curl
# Apache Configuration
COPY config/apache/000-default.conf /etc/apache2/sites-enabled/000-default.conf

# Install Php7
RUN apt-get --fix-missing -y install php7.0 libapache2-mod-php7.0
# Install Php7 Extension
RUN apt-get --fix-missing -y install libphp7.0-embed php7.0-bcmath php7.0-bz2 php7.0-cgi php7.0-cli php7.0-common php7.0-curl php7.0-dba php7.0-dev php7.0-enchant php7.0-fpm php7.0-gd php7.0-gmp php7.0-imap php7.0-interbase php7.0-intl php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-opcache php7.0-phpdbg php7.0-pspell php7.0-readline php7.0-recode php7.0-snmp php7.0-soap php7.0-tidy php7.0-xml php7.0-xmlrpc php7.0-xsl php7.0-zip
# Php Config
COPY config/php/php.ini /etc/php/7.0/cli/php.ini
# Source Code
COPY data/WebsiteTracker.tar.gz /home/
RUN cd /var/www/html/ && \
    rm -rf * && \
    mv /home/WebsiteTracker.tar.gz /var/www/html/WebsiteTracker.tar.gz && \
    tar xvf WebsiteTracker.tar.gz && \
    rm -rf WebsiteTracker.tar.gz

# Entrypoint
COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]