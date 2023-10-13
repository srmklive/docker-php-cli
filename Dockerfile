FROM srmklive/docker-ubuntu:latest

LABEL maintainer="Raza Mehdi<srmk@outlook.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get -y upgrade

RUN add-apt-repository ppa:ondrej/php \
  && apt-get update

RUN apt-get -y install libpcre3 openssl php8.3-cli php8.3-curl php8.3-mbstring \
  php8.3-mysql php8.3-pgsql php8.3-gd php8.3-bcmath php8.3-readline \
  php8.3-zip php8.3-imap php8.3-xml php8.3-intl php8.3-soap \
  php8.3-memcached php8.3-xdebug php8.3-redis

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php composer-setup.php --install-dir=/usr/bin --filename=composer \
  && php -r "unlink('composer-setup.php');" 

RUN apt-get -y autoclean \
  && apt-get -y autoremove \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
