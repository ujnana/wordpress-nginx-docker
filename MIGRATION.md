# Panduan Migrasi WordPress ke Docker

Ikuti panduan ini jika Anda memiliki situs WordPress lama (tanpa Docker) dan ingin memindahkannya ke stack Docker ini.

## 1. Backup di Server Lama

### Ekspor Database
Jalankan di server lama atau via phpMyAdmin:
```bash
mysqldump -u username_db -p nama_db_lama > backup_db.sql
```

### Kompres File wp-content
Kita hanya butuh folder `wp-content` (berisi tema, plugin, dan upload):
```bash
tar -czvf wp-content.tar.gz wp-content/
```

## 2. Pindahkan ke Server Baru (VPS Baru)

Gunakan `scp` atau `sftp` untuk memindahkan kedua file tersebut ke folder `wordpress-nginx-docker` di VPS baru.

## 3. Impor Database ke Docker

Pastikan container sudah berjalan (`docker compose up -d`).

Jalankan perintah ini untuk memasukkan database lama ke container MariaDB:
```bash
# Ganti wp_password sesuai .env Anda
docker exec -i wordpress_db mariadb -u wp_user -pwp_password wordpress < backup_db.sql
```

## 4. Pindahkan File wp-content ke Docker (Cara Mudah)

Karena kita menggunakan **Bind Mount**, Anda cukup memindahkan folder `wp-content` langsung ke folder yang ada di VPS Anda.

1. **Ekstrak file tar:**
   ```bash
   tar -xzvf wp-content.tar.gz
   ```
2. **Copy folder langsung di host (VPS):**
   ```bash
   cp -r wp-content/ wordpress_files/
   ```
3. **Perbaiki Permission via Docker:**
   Agar WordPress bisa menulis file, jalankan perintah ini (hanya sekali):
   ```bash
   docker exec -u 0 -it wordpress_app chown -R www-data:www-data /var/www/html/wp-content
   ```

## 5. Update Konfigurasi (Jika Domain Berubah)

Jika domain Anda berubah (misal dari `lama.com` ke `baru.com`), Anda perlu melakukan *Search and Replace* di database.

Gunakan tool `wp-cli` yang sudah ada di image wordpress kita:
```bash
docker exec -it wordpress_app wp search-replace 'http://domain-lama.com' 'https://domain-baru.com' --allow-root
```

## 6. Selesai!

Cek website Anda. WordPress sekarang seharusnya berjalan dengan data lama Anda di dalam lingkungan Docker.
