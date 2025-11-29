#!/bin/bash

set -e

echo "Starting WordPress setup..."

#WordPress가 이미 설치 되어있는지 확인

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "WordPress not found. Installing..."

    # WordPress 다운로드
    wp core download --allow-root --path=/var/www/html

    # MariaDB가 준비될 때까지 대기
    echo "Waiting for MariaDB..."
    while ! mysqladmin ping -h"${WORDPRESS_DB_HOST%:*}" --silent; do
        sleep 1
    done
    echo "MariaDB is ready"

    # wp-config.php 생성
    wp config create \
        --allow-root \
        --dbname="${WORDPRESS_DB_NAME}" \
        --dbuser="${WORDPRESS_DB_USER}" \
        --dbpass="${WORDPRESS_DB_PASSWORD}" \
        --dbhost="${WORDPRESS_DB_HOST}" \
        --path=/var/www/html

    # WordPress 설치
    wp core install \
        --allow-root \
        --url="${WORDPRESS_URL}" \
        --title="${WORDPRESS_TITLE}" \
        --admin_user="${WORDPRESS_ADMIN_USER}" \
        --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
        --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
        --path=/var/www/html

    # 추가 사용자 생성 (관리자 아닌 일반 사용자)
    wp user create \
        --allow-root \
        "${WORDPRESS_USER}" \
        "${WORDPRESS_USER_EMAIL}" \
        --user_pass="${WORDPRESS_USER_PASSWORD}" \
        --role=editor \
        --path=/var/www/html
    
    echo "WordPress installation complete!"
else
    echo "WordPress already installed. Skipping installation."
fi

# 권한 설정
chown -R www-data:www-data /var/www/html

echo "Starting PHP-FPM..."


# PHP-FPM 실행
exec "$@"
