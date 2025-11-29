#!/bin/bash

# mariaDB 초기화 스크립트

set -e

# mariaDB 데이터 디렉토리 확인


if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."

    # MariaDB 데이터 디렉토리 초기화
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # 임시 MariaDB 서버 시작
    mysqld --user=mysql --bootstrap --verbose=0 << EOF

USE mysql;
FLUSH PRIVILEGES;

-- root 비밀번호 설정
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

-- 데이터베이스 생성
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

-- 사용자 생성 및 권한 부여
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

-- root 원격 접속 허용 (선택사항)
-- CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
-- GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;

FLUSH PRIVILEGES;
EOF

    echo "MariaDB initialization complete."
else
    echo "MariaDB data directory already exists. Skipping initialization."
fi

# 메인 프로세스 실행 (CMD로 전달된 명령)
exec "$@"