FROM srmklive/docker-ubuntu:latest

LABEL maintainer="Raza Mehdi<srmk@outlook.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get -y upgrade

RUN add-apt-repository ppa:ondrej/php \
  && apt-get update

RUN apt-get -y install libpcre3 libssl1.1 openssl php7.4-cli php7.4-curl php7.4-mbstring \
  php7.4-json php7.4-mysql php7.4-pgsql php7.4-gd php7.4-bcmath php7.4-readline \
  php7.4-zip php7.4-imap php7.4-xml php7.4-json php7.4-intl php7.4-soap \
  php7.4-memcached php-xdebug

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php -r "if (hash_file('sha384', 'composer-setup.php') === '795f976fe0ebd8b75f26a6dd68f78fd3453ce79f32ecb33e7fd087d39bfeb978342fb73ac986cd4f54edd0dc902601dc') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php composer-setup.php --install-dir=/usr/bin --filename=composer \
  && php -r "unlink('composer-setup.php');"   

RUN apt-get -y autoclean \
  && apt-get -y autoremove \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
