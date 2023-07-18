FROM srmklive/docker-ubuntu:latest

LABEL maintainer="Raza Mehdi<srmk@outlook.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get -y upgrade

RUN add-apt-repository ppa:ondrej/php \
  && apt-get update

RUN apt-get -y install libpcre3 openssl php8.1-cli php8.1-curl php8.1-mbstring \
  php8.1-mysql php8.1-pgsql php8.1-gd php8.1-bcmath php8.1-readline \
  php8.1-zip php8.1-imap php8.1-xml php8.1-intl php8.1-soap \
  php8.1-memcached php8.1-xdebug php8.1-redis

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php composer-setup.php --install-dir=/usr/bin --filename=composer \
  && php -r "unlink('composer-setup.php');" 

RUN apt-get -y autoclean \
  && apt-get -y autoremove \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
