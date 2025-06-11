#!/bin/bash
set -e

echo "[PROD] Copying prod Nginx config..."
mkdir -p /home/ubuntu/conf.d
cp ./nginx-config/prod.conf /home/ubuntu/conf.d/default.conf

echo "[PROD] Restarting container..."
docker stop mynginx || true
docker rm mynginx || true

docker run -d --name mynginx \
  -p 443:443 \
  -v /home/ubuntu/conf.d:/etc/nginx/conf.d \
  -v /home/ubuntu/ssl:/etc/nginx/ssl \
  nginx

echo "[✓] Prod Nginx deployed!"
