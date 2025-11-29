# Debian 12 (Bookworm) 기반

FROM debian:bookworm

# 패키지 업데이트 및 MariaDB 서버 설치
RUN apt-get update && \
    apt-get install -y \
    mariadb-server \
    mariadb-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# MariaDB 기본 데이터베이스 삭제 (중요!)
RUN rm -rf /var/lib/mysql/*

# MariaDB 설정 파일 복사
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# 초기화 스크립트 복사
COPY tools/init_db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init_db.sh

# MariaDB 데이터 디렉토리 권한 설정
RUN mkdir -p /var/run/mysqld && \
    mkdir -p /var/log/mysql && \
    chown -R mysql:mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/log/mysql
    #chown -R mysql:mysql /var/lib/mysql && \
    

# 3306 포트 노출
EXPOSE 3306

# 초기화 스크립트를 entrypoint로 실행
ENTRYPOINT ["init_db.sh"]

# mariaDB 서버를 포그라운드로 실행
CMD ["mysqld", "--user=mysql", "--console"]
