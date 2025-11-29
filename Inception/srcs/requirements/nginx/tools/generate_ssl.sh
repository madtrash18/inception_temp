#!/bin/bash

set -e

SSL_CERT="/etc/nginx/ssl/nginx.crt"
SSL_KEY="/etc/nginx/ssl/nginx.key"

# SSL 인증서가 이미 존재하는지 확인
if [ ! -f "$SSL_CERT" ] || [ ! -f "$SSL_KEY" ]; then
    echo "Generating SSL certificate..."

    # 자체 서명 SSL 인증서 생성
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout "$SSL_KEY" \
        -out "$SSL_CERT" \
        -subj "/C=KR/ST=Gyeongsangnam-do/L=Gyeongsan/O=42gyeongsan/OU=djang/CN=djang.42.fr"

    chmod 644 "$SSL_CERT"
    chmod 600 "$SSL_KEY"

    echo "SSL certificate generated successfully."
else
    echo "SSL certificate already exists. Skipping generation."
fi
