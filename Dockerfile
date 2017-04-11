FROM       resin/rpi-raspbian
MAINTAINER Martin Stepahne  <martin.stephane@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    curl

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN echo "deb [arch=armhf] https://download.docker.com/linux/debian jessie stable" \
    | tee /etc/apt/sources.list.d/docker.list

RUN echo "deb https://packagecloud.io/Hypriot/Schatzkiste/debian/ jessie main" \
    | tee /etc/apt/sources.list.d/hypriot.list

RUN apt-key adv \
    --keyserver keyserver.ubuntu.com \ 
    --recv-keys 37BBEE3F7AD95B3F

RUN apt-get update && apt-get install -y --no-install-recommends \
    docker-ce \
    docker-compose \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

COPY docker_volume_backup.sh /

ENTRYPOINT ["/docker_volume_backup.sh", "/project/docker-compose.yml"]
