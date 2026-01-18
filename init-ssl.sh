#!/bin/bash

# Load environment variables
if [ -f .env ]; then
    export $(cat .env | xargs)
fi

echo "Requesting Let's Encrypt certificate for $DOMAIN_NAME..."

docker-compose run --rm certbot certonly --webroot --webroot-path=/var/www/certbot \
    --email $EMAIL --agree-tos --no-eff-email \
    -d $DOMAIN_NAME

echo "Certificate request complete. Please uncomment SSL lines in nginx/conf.d/wordpress.conf and restart Nginx."
