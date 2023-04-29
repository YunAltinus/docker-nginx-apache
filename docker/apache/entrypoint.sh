#!/bin/bash

if [ ! -f "vendor/autoload.php" ]; then
    composer install --no-progress --no-interaction --ignore-platform-reqs
fi

if [ ! -f ".env" ]; then
    echo "Creating env file for env $APP_ENV"
    cp .env.example .env
else
    echo "env file exists."
fi

php artisan key:generate
php artisan config:clear
php artisan view:clear
php artisan route:clear
php artisan cache:clear

role=${CONTAINER_ROLE:-app}

if [ "$role" = "app" ]; then
    source /etc/apache2/envvars
    /usr/sbin/apache2 -D FOREGROUND
elif [ "$role" = "queue" ]; then
    # php /var/www/html/artisan horizon
    
    supervisord -n
    supervisorctl start all
fi
