#
# PHP-FPM 7.1 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

FROM php:7.1-fpm

MAINTAINER Dongasai 1514582970@qq.com

ENV PHALCON_VERSION=3.1.2
ENV IM_VERSION=6.9.9-34

RUN curl -sSL "https://codeload.github.com/phalcon/cphalcon/tar.gz/v${PHALCON_VERSION}" | tar -xz \
    && cd cphalcon-${PHALCON_VERSION}/build \
    && ./install \
    && cp ../tests/_ci/phalcon.ini $(php-config --configure-options | grep -o "with-config-file-scan-dir=\([^ ]*\)" | awk -F'=' '{print $2}') \
    && cd ../../ \
    && rm -r cphalcon-${PHALCON_VERSION}
RUN apt-get update;
RUN docker-php-ext-install pdo pdo_mysql;docker-php-ext-enable pdo pdo_mysql;
RUN pecl install redis-3.1.6 \
    && pecl install xdebug-2.5.0 \
    && docker-php-ext-enable redis xdebug
RUN apt-get install -y libmemcached-dev zlib1g-dev \
    && pecl install memcached-3.0.4\
    && docker-php-ext-enable memcached
# 安装 ImageMagick
RUN wget wget ftp://ftp.imagemagick.org/pub/ImageMagick/ImageMagick-${IM_VERSION}.tar.gz
RUN tar zxvf ImageMagick-${IM_VERSION}.tar.gz \
    && rm ImageMagick-${IM_VERSION}.tar.gz \
    && cd ImageMagick-${IM_VERSION} \
    && ./configure --prefix=/usr/local/imagemagick \
    && make \
    && make install
RUN pecl install imagick-3.4.3 --with-imagick=/usr/local/imagemagick;docker-php-ext-enable imagick
