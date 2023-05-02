## Nginx - Fpm - OPCACHE

Laravel Docker Nginx build using PHP-FPM and OP_CACHE.

This build delivers top performance.

By using nginx, php-fpm and op_cache, were able to reduce our request response times and serve requests in 5ms!

## Apache
Also, if you wanna using apache by web server.

## Docker
Run ```docker-compose -f docker-compose.nginx.yml up --force-recreate --build -d```

OR:

Run ```docker-compose -f docker-compose.apache.yml up --force-recreate --build -d```

### Ports

Default PHP port is 8000. Connect via http://127.0.0.1:8000 or http://localhost:8000

And using vue with vite in php container

Default DB port is 3306.

Default Phpmyadmin port is 8001.

Default Redis port is 6379.

Default Redis-ui port is 8002.

Default Queue panel http://localhost:8000/horizon

## License

The Laravel framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
