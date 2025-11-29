# Debian 12 (Bookworm) 기반

FROM debian:bookworm

# 패키지 업데이트 및 필요한 패키지 설치

RUN apt-get update && \
    apt-get install -y \
    php8.2-fpm \
    php8.2-mysql \
    php8.2-mysqli \
    php8.2-curl \
    php8.2-gd \
    php8.2-intl \
    php8.2-mbstring \
    php8.2-soap \
    php8.2-xml \
    php8.2-xmlrpc \
    php8.2-zip \
    wget \
    curl \
    mariadb-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# WP-CLI 설치 (WordPress 명령줄 도구)
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# PHP-FPM 설정 파일 복사
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# WordPress 설치 스크립트 복사
COPY tools/setup_wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup_wordpress.sh

# WordPress 디렉토리 생성 및 권한 설정
RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html

# PHP-FRM 실행 디렉토리 생성
RUN mkdir -p /run/php && \
    chown www-data:www-data /run/php

# 작업 디렉토리 설정
WORKDIR /var/www/html

# 9000 포트노출 (PHP-FRM)
EXPOSE 9000

# 초기화 스크립트 실행
ENTRYPOINT ["setup_wordpress.sh"]

# PHP-FPM을 포그라운드로 실헹
CMD ["php-fpm8.2", "-F"]




