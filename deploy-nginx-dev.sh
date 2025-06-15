#!/bin/bash


set -e

echo "[+] Preparing Nginx config directory..."
mkdir -p /home/ubuntu/conf.d

echo "[+] Copying dev.conf to /home/ubuntu/conf.d..."
cp ./nginx-config/dev.conf /home/ubuntu/conf.d/

echo "[+] Stopping existing container..."
docker stop mynginx || true

echo "[+] Removing existing container..."
docker rm mynginx || true

echo "[+] Running new Nginx container..."
docker run -d --name mynginx \
  -p 443:443 \
  -v /home/ubuntu/conf.d:/etc/nginx/conf.d \
  -v /home/ubuntu/ssl:/etc/nginx/ssl \
  nginx

echo "[✓] Nginx deployment complete!"
