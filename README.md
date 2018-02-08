# phalcon_php_fpm
phalcon_php_fpm


# 安装 ImageMagick
RUN wget wget ftp://ftp.imagemagick.org/pub/ImageMagick/ImageMagick-${IM_VERSION}.tar.gz
RUN tar zxvf ImageMagick-${IM_VERSION}.tar.gz \
    && rm ImageMagick-${IM_VERSION}.tar.gz \
    && cd ImageMagick-${IM_VERSION} \
    && ./configure --prefix=/usr/local/imagemagick \
    && make \
    && make install
RUN pecl install imagick-3.4.3 --with-imagick=/usr/local/imagemagick;docker-php-ext-enable imagick


PUBLIC
/etc/apache2/apache2.conf