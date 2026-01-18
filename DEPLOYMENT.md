# Panduan Deployment ke VPS

Ikuti langkah-langkah di bawah ini untuk deploy stack WordPress Anda ke VPS (Ubuntu/Debian direkomendasikan).

## 1. Persiapan Server (VPS)

Instal Docker dan Docker Compose di VPS Anda:

```bash
# Update package list
sudo apt-get update

# Instal Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Instal Docker Compose
sudo apt-get install -y docker-compose-plugin
```

## 2. Pengaturan DNS

Arahkan domain/subdomain Anda ke IP Publik VPS melalui panel DNS (A Record):
- `example.com` -> `IP_VPS`
- `www.example.com` -> `IP_VPS` (Opsional)

## 3. Clone Repository & Konfigurasi

Jalankan perintah ini di dalam VPS:

```bash
# Clone repo
git clone <URL_REPO_ANDA>
cd wordpress-nginx-docker

# Konfigurasi .env
# Edit file .env sesuai kebutuhan produksi
```

**Edit file `.env`**:
- `DOMAIN_NAME`: Isi dengan domain asli (contoh: `example.com`).
- `EMAIL`: Isi dengan email untuk notifikasi Let's Encrypt.
- `MYSQL_ROOT_PASSWORD`: Ganti dengan password yang sangat kuat.
- **Salts**: Update semua key salt dari [wordpress.org/secret-key](https://api.wordpress.org/secret-key/1.1/salt/).

## 4. Jalankan Aplikasi

Build dan jalankan container:

```bash
docker compose up -d --build
```

## 5. Aktivasi SSL (HTTPS)

Jalankan script SSL yang sudah kita siapkan:

```bash
chmod +x init-ssl.sh
./init-ssl.sh
```

Setelah script selesai, restart Nginx agar sertifikat baru terbaca:
```bash
docker compose restart nginx
```

## 6. Selesai!

Sekarang WordPress Anda dapat diakses melalui:
- **WordPress**: `https://domain-anda.com`
- **phpMyAdmin**: `http://domain-anda.com:8080` (Disarankan tutup port 8080 di firewall jika tidak digunakan).

---

> [!TIP]
> **Firewall (UFW)**: Pastikan port 80 (HTTP) dan 443 (HTTPS) terbuka.
> `sudo ufw allow 80,443/tcp`
