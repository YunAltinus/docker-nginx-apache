FROM php:8.4.1-cli-alpine3.20 as php

RUN usermod -u 1000 www-data

# Install node and Yarn in workspace container
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -y
RUN apt-get install -y curl unzip libzip-dev libpq-dev libcurl4-gnutls-dev libmariadb-dev nginx git zip unzip libjpeg62-turbo-dev libssl-dev gnupg2 yarn sudo supervisor
RUN docker-php-ext-install pdo pdo_mysql mysqli bcmath curl pcntl zip
RUN docker-php-ext-enable pcntl

RUN pecl update-channels 
RUN pecl install -o -f redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis

WORKDIR /var/www/html

COPY --chown=www-data:www-data . .

COPY ./docker/apache/php.ini /usr/local/etc/php/php.ini
COPY ./docker/apache/vhost.conf /etc/apache2/sites-available/000-default.conf

COPY ./docker/horizon/supervisord.conf /etc/supervisor/conf.d/horizon.conf

# Apache configs + document root.
RUN echo "ServerName laravel-app.local" >> /etc/apache2/apache2.conf

COPY --from=composer:2.3.5 /usr/bin/composer /usr/bin/composer

RUN chmod -R 755 /var/www/html/storage
RUN chmod -R 755 /var/www/html/bootstrap

RUN chmod -R 755 /var/www/html/docker/apache/entrypoint.sh

ENTRYPOINT [ "docker/apache/entrypoint.sh" ]

VOLUME /var/www/html/vendor