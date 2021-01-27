FROM php:7.4-apache

WORKDIR /var/www/html/

ARG UNO_VERSION=1.6.2

RUN apt-get update && apt-get install -y \
  wget \
  netcat-traditional \
  && rm -rf /var/lib/apt/lists/*

USER www-data

RUN wget https://github.com/boiteasite/cmsuno/archive/$UNO_VERSION.tar.gz -O /tmp/uno.tar.gz \
  && tar xaf /tmp/uno.tar.gz -C /var/www/html --strip-components=1 \
  && rm /tmp/uno.tar.gz \
  && chmod -R 755 /var/www/html/
