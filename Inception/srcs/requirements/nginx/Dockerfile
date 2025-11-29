# Debian 12 (Bookworm) 기반
FROM debian:bookworm

# 패키지 업데이트 및 NGINX, OpenSSL 설치
RUN apt-get update && \
    apt-get install -y \
    nginx \
    openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# NGIX 설정 파일 복사
COPY conf/nginx.conf /etc/nginx/nginx.conf

# SSL 인증서 생성 스크립트 복사
COPY tools/generate_ssl.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/generate_ssl.sh

# SSL 디렉토리 생성
RUN mkdir -p /etc/nginx/ssl

# NGINX 실행 디렉토리 생성
RUN mkdir -p /var/run/nginx

# 443 포트 노출
EXPOSE 443

# SSL 인증서 생성 후 NGINX 실행
CMD ["bash", "-c", "generate_ssl.sh && nginx -g 'daemon off;'"]

