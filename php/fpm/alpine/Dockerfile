FROM php:fpm-alpine



RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk update
RUN apk add libpq-dev

# Install PHP extensions
RUN docker-php-ext-install \
      # gettext \
      pdo_mysql \
      pdo_pgsql
