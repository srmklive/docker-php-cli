FROM srmklive/docker-ubuntu:latest

LABEL maintainer="Raza Mehdi<srmk@outlook.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get -y upgrade

RUN add-apt-repository ppa:ondrej/php \
  && apt-get update

RUN apt-get -y install libssl1.1 openssl php7.1-cli php7.1-curl php7.1-mcrypt \
  php7.1-mbstring php7.1-zip php7.1-json php7.1-mysql php7.1-pgsql php7.1-gd \
  php7.1-bcmath php7.1-imap php7.1-xml php7.1-json php7.1-intl php7.1-soap \
  php7.1-readline php7.1-memcached php-xdebug

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php -r "if (hash_file('sha384', 'composer-setup.php') === 'a5c698ffe4b8e849a443b120cd5ba38043260d5c4023dbf93e1558871f1f07f58274fc6f4c93bcfd858c6bd0775cd8d1') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php composer-setup.php --install-dir=/usr/bin --filename=composer \
  && php -r "unlink('composer-setup.php');"  

RUN apt-get -y autoclean \
  && apt-get -y autoremove \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
