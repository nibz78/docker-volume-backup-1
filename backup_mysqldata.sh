
#! /bin/sh
docker run --rm -v /backup:/backup -v pi_mysqldata:/data armhf/alpine tar -zcvf /backup/pi_mysqldata-$(date -I).tar /data


