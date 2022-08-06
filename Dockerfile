FROM debian:latest
LABEL maintainer="pasha.demichev@gmail.com"
ARG USER_ID=1000
ARG GROUP_ID=100
ARG QBIT_WEBUI_PASS=""

ENV TZ=Pacific/Auckland
ENV QBIT_CONFIG_PATH="/home/qbittorrent/.config/qBittorrent/qBittorrent.conf"

COPY bin/ /tmp/qbittorrent/
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt-get update && apt-get install -y python3 qbittorrent-nox && \
    mkdir -p /opt/qbittorrent/download && \
    useradd -u $USER_ID -g $GROUP_ID -m qbittorrent && \
    chmod +x /tmp/qbittorrent/setup.sh && \
    /bin/bash -c /tmp/qbittorrent/setup.sh && \
    chown -R qbittorrent:users /home/qbittorrent && \
    rm -rf /tmp/qbittorrent
 
EXPOSE 8080 6881:6881/tcp 6881:6881/udp
USER qbittorrent
CMD [ "qbittorrent-nox" ]