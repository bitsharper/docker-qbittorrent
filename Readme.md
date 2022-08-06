```
qbittorrent docker container wich allows to set WebUI password during container build.
If password not specified during build stage it will be generated.


docker build . -t qbittorrent/debian --build-arg QBIT_WEBUI_PASS=password

docker run -d --name qbittorrent -p 8080:8080 -p 6881:6881 -p 6881:6881/udp \
      --mount type=bind,source=/mnt/sata/netdrive/tmp,target=/opt/qbittorrent/download \
      --restart=unless-stopped qbittorrent/debian