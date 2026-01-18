# WordPress Docker Setup (Nginx + MariaDB + Redis)

This repository provides a complete, production-ready WordPress environment using Docker Compose. It features a high-performance stack including Nginx, MariaDB, Redis for caching, and PHPMyAdmin for database management.

## 🚀 Features

- **WordPress 6.4 (FPM)**: Customized Alpine-based image with essential PHP extensions (`bcmath`, `exif`, `gd`, `intl`, `mysqli`, `zip`).
- **Nginx Stable**: Optimized configuration for WordPress with security headers and static asset caching.
- **MariaDB 10.11**: Reliable and fast database.
- **Redis**: Integrated for Object Caching to improve performance.
- **PHPMyAdmin**: Web interface for managing the database.
- **Environment Driven**: Easily configurable via a `.env` file.

## 📋 Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## 🛠️ Getting Started

### 1. Clone the repository
```bash
git clone <repository-url>
cd wordpress-nginx-docker
```

### 2. Configure Environment Variables
Copy the example environment file and update it with your desired credentials and keys.
```bash
cp .env.example .env # If an example file exists, otherwise edit .env directly
```
> [!IMPORTANT]
> Make sure to update the **WordPress Salts** in the `.env` file using the [WordPress Salt Generator](https://api.wordpress.org/secret-key/1.1/salt/).

### 3. Launch the stack
```bash
docker compose up -d
```

## 🌐 Accessing the Services

Once the containers are running, you can access the services at:

| Service      | URL                   | Port |
|--------------|-----------------------|------|
| **WordPress**| http://localhost:8081 | 8081 |
| **PHPMyAdmin**| http://localhost:8080 | 8080 |

## ⚙️ Configuration Details

### Nginx
The Nginx configuration is located in `nginx/conf.d/wordpress.conf`. It is configured to:
- Serve static files directly with long expiration headers.
- Pass PHP requests to the WordPress container via FPM on port 9000.
- Include security headers: `X-Frame-Options`, `X-XSS-Protection`, and `X-Content-Type-Options`.

### WordPress Customizations
The WordPress image is build from `wordpress/Dockerfile` and includes:
- System dependencies for ImageMagick and GD.
- Redis PHP extension for integration with the Redis container.
- Custom `php.ini` settings (via `php/php.ini`).

## 💾 Persistence
Data persistence is handled via Docker volumes:
- `db_data`: Stores MariaDB data.
- `wordpress_data`: Stores WordPress files (web root).

## 🐳 Docker Services

- **db**: MariaDB database container.
- **wordpress**: PHP-FPM container with WordPress source and required extensions.
- **nginx**: Web server container serving as a reverse proxy for WordPress.
- **redis**: Redis container for application caching.
- **phpmyadmin**: Database management tool.
