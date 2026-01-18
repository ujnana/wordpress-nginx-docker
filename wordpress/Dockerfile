FROM wordpress:6.4-fpm-alpine

# Install system dependencies
RUN apk add --no-cache \
    bash \
    curl \
    ca-certificates \
    imagemagick \
    imagemagick-dev \
    libzip-dev \
    icu-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    build-base \
    autoconf \
    libtool

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Install PHP extensions
# Note: opcache and imagick may already be in the base image, 
# but we ensure dependencies and other required extensions are present.
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
    bcmath \
    exif \
    gd \
    intl \
    mysqli \
    zip

# Install and enable redis extension
RUN pecl install redis \
    && docker-php-ext-enable redis

# Clean up
RUN apk del build-base autoconf libtool \
    && rm -rf /var/cache/apk/*

# Copy custom php.ini
COPY ./php/php.ini /usr/local/etc/php/conf.d/custom.ini

WORKDIR /var/www/html
