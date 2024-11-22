## Description
Dockerfile to deploy qbittorrent container. It allows to set WebUI password during container build to avoid using defaul qbittorrent adminadmin password. 
If a password wasn't set during build stage a random password will be generated and output to the console during the container build stage. 

## Container build and run example

```
docker build . -t debian/qbittorrent --build-arg QBIT_WEBUI_PASS=password

docker run -d --name qbittorrent -p 8080:8080 -p 6881:6881 -p 6881:6881/udp \
      --mount type=bind,source=/tmp,target=/opt/qbittorrent/download \
      --restart=unless-stopped debian/qbittorrent
```