FROM armhf/alpine:latest

WORKDIR /root/

RUN apk add --update curl ca-certificates mysql-client docker

ADD backup_mysqldata.sh backup_mysqldata.sh
RUN chmod +x  backup_mysqldata.sh

ADD mycrontab mycrontab

ADD entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

CMD ["/root/entrypoint.sh"]

