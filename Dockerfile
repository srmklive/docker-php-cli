FROM srmklive/docker-ubuntu:18.04

LABEL maintainer="Raza Mehdi<srmk@outlook.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get -y upgrade

RUN add-apt-repository ppa:ondrej/php \
  && apt-get update

RUN apt-get -y install libssl1.1 openssl php7.0-cli php7.0-curl php7.0-mbstring php7.0-curl \
  php7.0-json php7.0-mysql php7.0-pgsql php7.0-gd php7.0-bcmath php7.0-readline php7.0-zip \
  php7.0-imap php7.0-xml php7.0-json php7.0-intl php7.0-soap php7.0-memcached php7.0-xdebug

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php composer-setup.php --install-dir=/usr/bin --filename=composer --2.2 \
  && php -r "unlink('composer-setup.php');"  

RUN apt-get -y autoclean \
  && apt-get -y autoremove \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
