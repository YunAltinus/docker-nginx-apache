FROM php:8.4.1-cli-alpine3.20 as php

ENV PHP_OPCACHE_ENABLE=1
ENV PHP_OPCACHE_ENABLE_CLI=0
ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS=1
ENV PHP_OPCACHE_REVALIDATE_FREQ=1

WORKDIR /var/www/html

RUN usermod -u 1000 www-data

# Install node and Yarn in workspace container
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -y
RUN apt-get install -y curl unzip libzip-dev libpq-dev libcurl4-gnutls-dev libmariadb-dev nginx git zip unzip libjpeg62-turbo-dev libssl-dev gnupg2 yarn sudo supervisor

RUN docker-php-ext-install pdo pdo_mysql mysqli bcmath curl opcache pcntl zip
RUN docker-php-ext-enable opcache pcntl

RUN pecl update-channels
RUN pecl install -o -f redis \
  && rm -rf /tmp/pear \
  && docker-php-ext-enable redis

COPY --chown=www-data:www-data . .

COPY ./docker/nginx-fpm-opcache/php.ini /usr/local/etc/php/php.ini
COPY ./docker/nginx-fpm-opcache/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY ./docker/nginx-fpm-opcache/php-fpm.conf /usr/local/etc/php-fpm.d/www.conf 

COPY ./docker/nginx-fpm-opcache/nginx.conf /etc/nginx/nginx.conf

COPY ./docker/horizon/supervisord.conf /etc/supervisor/conf.d/horizon.conf

COPY --from=composer:2.3.5 /usr/bin/composer /usr/bin/composer

RUN chmod -R 755 /var/www/html/storage
RUN chmod -R 755 /var/www/html/bootstrap
RUN chmod -R 777 /var/www/html

RUN chmod +x docker/nginx-fpm-opcache/entrypoint.sh

ENTRYPOINT [ "docker/nginx-fpm-opcache/entrypoint.sh" ]

VOLUME /var/www/html/vendor