#!/bin/bash

set -e  # Dừng script nếu có lỗi

echo "Đang cài đặt Code-Server..."
curl -fsSL https://code-server.dev/install.sh | sh

echo "Đang chạy Code-Server..."
code-server --bind-addr 0.0.0.0:8080 --auth=none &

echo "Đang cài đặt Ngrok..."
curl -sSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.tgz | tar -xz -C /usr/local/bin
chmod +x /usr/local/bin/ngrok

echo "Đang mở tunnel Ngrok..."
ngrok config add-authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5
ngrok http 8080 > /dev/null &

sleep 5
NGROK_URL=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*')

echo "Ngrok URL: ${NGROK_URL:-Lỗi: Không lấy được URL Ngrok!}"

exec tail -f /dev/null
