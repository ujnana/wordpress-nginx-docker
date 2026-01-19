#!/bin/bash

# Load environment variables (handling special characters)
if [ -f .env ]; then
    set -a
    source .env
    set +a
fi

echo "Requesting Let's Encrypt certificate for $DOMAIN_NAME..."

# We use --entrypoint certbot to override the renewal loop in docker-compose.yml
docker compose run --rm --entrypoint certbot certbot certonly --webroot --webroot-path=/var/www/certbot \
    --email $EMAIL --agree-tos --no-eff-email \
    -d $DOMAIN_NAME

echo "Certificate request complete. Please uncomment SSL lines in nginx/conf.d/wordpress.conf and restart Nginx."
