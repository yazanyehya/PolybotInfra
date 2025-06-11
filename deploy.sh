#!/bin/bash

echo "🔁 Stopping and removing existing Nginx container (if any)..."
docker stop mynginx || true
docker rm mynginx || true

echo "🚀 Starting new Nginx container..."
docker run -d --name mynginx -p 443:443 \
  -v /home/ubuntu/conf.d:/etc/nginx/conf.d \
  -v /home/ubuntu/ssl:/etc/nginx/ssl \
  nginx

echo "✅ Nginx container deployed successfully!"
