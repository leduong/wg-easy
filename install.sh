#!/bin/bash

PUBLIC_IP=$(curl -4 -s ifconfig.me)
PASSWORD_HASH='$2a$12$Auf6KaTY1RRGLPNyvDUfF.zf2BVjo4KfBq7HV5ISKJ.xv7SnZNyJS'

docker rm -f wg-easy && \
docker system prune -a -f && \
docker run -d --name=wg-easy \
  -e LANG=en \
  -e WG_HOST=$PUBLIC_IP \
  -e PASSWORD_HASH=$PASSWORD_HASH \
  -v ~/.wg-easy:/etc/wireguard \
  -p 51820:51820/udp \
  -p 51821:51821/tcp \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE \
  --sysctl="net.ipv4.conf.all.src_valid_mark=1" \
  --sysctl="net.ipv4.ip_forward=1" \
  --restart unless-stopped leduong/wg-easy:latest