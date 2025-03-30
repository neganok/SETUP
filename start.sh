#!/bin/bash


echo "Đang cài đặt Node.js..."
curl -fsSL https://deb.nodesource.com/setup_current.x | bash

# Cài đặt Ngrok
echo "Đang cài đặt Ngrok..."
curl -sSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.tgz | tar -xz -C /usr/local/bin
chmod +x /usr/local/bin/ngrok

# Cài đặt Code-Server từ npm
echo "Đang cài đặt Code-Server..."
npm install -g code-server

# Chạy Code-Server
echo "Đang chạy Code-Server..."
code-server --bind-addr 0.0.0.0:8080 --auth=none &

# Cấu hình và khởi động Ngrok
echo "Đang mở tunnel Ngrok..."
ngrok config add-authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5
ngrok http 8080 > /dev/null &

# Đợi Ngrok khởi động và lấy public URL
sleep 5
NGROK_URL=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*')

echo "${NGROK_URL:-Lỗi: Không lấy được URL Ngrok!}"

# Giữ tiến trình chạy
exec tail -f /dev/null
