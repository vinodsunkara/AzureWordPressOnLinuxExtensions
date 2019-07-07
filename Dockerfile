FROM appsvcorg/wordpress-alpine-php:0.72
RUN apk add --update --no-cache autoconf g++ imagemagick-dev libtool make pcre-dev
#RUN pecl install imagick 
RUN apk add --update --no-cache imagemagick-libs
RUN apk add --update php-mbstring
RUN docker-php-ext-install exif
RUN docker-php-ext-install bcmath