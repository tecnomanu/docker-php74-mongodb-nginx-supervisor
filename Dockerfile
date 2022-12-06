FROM incubit/php74-mysql-laravel-nginx:latest
# Install MongodDB Driver
# fist at all install dependences
RUN apk add --no-cache \
                $PHPIZE_DEPS \
                openssl-dev
RUN pecl install mongodb
RUN docker-php-ext-enable mongodb

COPY ./docker-compose/supervisord/supervisord.ini /etc/supervisor.d/supervisord.ini
# Config PHP
COPY ./docker-compose/php/local.ini /usr/local/etc/php/php.ini

COPY ./docker-compose/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./docker-compose/nginx/conf.d/app.conf /etc/nginx/http.d/default.conf

EXPOSE 80
EXPOSE 443

CMD ["supervisord", "-c", "/etc/supervisor.d/supervisord.ini"]
