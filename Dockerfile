ARG PHP_VARIANT=8.2

FROM php:${PHP_VARIANT}

LABEL maintainer="MilesChou <github.com/MilesChou>, fizzka <github.com/fizzka>"

ARG PHALCON_VERSION=5.4.0

RUN set -xe && \
        docker-php-source extract && \
        # Install ext-phalcon
        cd /tmp && \
        curl -LO https://github.com/phalcon/cphalcon/releases/download/v${PHALCON_VERSION}/phalcon-pecl.tgz && \
        tar xzf phalcon-pecl.tgz && \
        docker-php-ext-install -j $(getconf _NPROCESSORS_ONLN) \
            /tmp/phalcon-${PHALCON_VERSION} \
        && \
        # Remove all temp files
        rm -r /tmp/phalcon-* && \
        docker-php-source delete && \
        php -m

COPY docker-phalcon-* /usr/local/bin/

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories


# Install PHP extensions
RUN docker-php-ext-install \
      # gettext \
      pdo_mysql 

# # Install PHP extensions
# RUN docker-php-ext-enable \
#       opcache \
#       phalcon 

# Install  composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');" && \
    composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
    
# Install  phalcon devtools
RUN docker-phalcon-install-devtools 
