#!/bin/bash

compose_file_path=$1
project_name=${2,,}
backup_path=$3
backup_or_restore=$4
restore_date=$5
user=pi

set -e

function backup_volume {
  volume_name=$1
  backup_destination=$2
  date_suffix=$(date -I)

  docker run --rm -v $volume_name:/data -v $backup_destination:/backup armhf/alpine tar -zcvf /backup/$volume_name-$date_suffix.tar /data
}

function restore_volume {
  volume_name=$1
  backup_destination=$2
  date=$3

  docker run --rm -v $volume_name:/data armhf/alpine find /data -mindepth 1 -delete
  docker run --rm -v $volume_name:/data -v $backup_destination:/backup armhf/alpine tar -xvf /backup/$volume_name-$date.tar -C .
}

function main {
  echo "Stopping running containers"
  #docker-compose -f $compose_file_path -p $project_name stop
  #docker-compose -f $compose_file_path -p $project_name pause $project_name 
  docker pause $project_name

  echo "Mounting volumes and performing backup/restore..."
  volumes=($(docker volume ls -f name=$user_$project_name\data | awk '{if (NR > 1) print $2}'))
  for v in "${volumes[@]}"
  do
    if [ "$backup_or_restore" == "backup" ]
    then
      echo "Perform backup"
      backup_volume $v $backup_path
    fi

    if [ "$backup_or_restore" == "restore" ]
    then
      echo "Restore from backup"
      restore_volume $v $backup_path $restore_date
    fi
  done

  echo "Restarting containers"
  #docker-compose -f $compose_file_path -p $project_name unpause $project_name
  docker unpause $project_name
}

main
