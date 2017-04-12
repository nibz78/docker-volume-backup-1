#!/bin/sh

#export MINIO_HOST_IP=$(/sbin/ip route|awk '/default/ { print $3 }')
#echo "MINIO_HOSt_IP:" $MINIO_HOST_IP

#mc config host add minio http://$MINIO_HOST_IP:9000 nibz78 ?Nitram78250
#mc ls minio
#mc mirror -w --force --remove /root minio/docker-volume-mysql > /dev/null &
 
if [ ! -e mycrontab ]; then
	echo "No crontab file found!"
	exit 1
fi

# Copy crontab file into the right place
cp mycrontab /etc/crontabs/root

# Run cron in the foreground
crond -f


