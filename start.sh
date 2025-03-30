#!/bin/bash
set -e  # Dừng script nếu có lỗi

echo "Đang cài đặt Code-Server..."
curl -fsSL https://code-server.dev/install.sh | sh

echo "Đang chạy Code-Server..."
nohup code-server --bind-addr 0.0.0.0:8080 --auth none &

echo "Đang cài đặt Ngrok..."
wget -qO /usr/local/bin/ngrok https://bin.equinox.io/c/bNyj1mQVY4E/ngrok-stable-linux-amd64
chmod +x /usr/local/bin/ngrok

echo "Đang mở tunnel Ngrok..."
/usr/local/bin/ngrok authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5
nohup /usr/local/bin/ngrok http 8080 &

# Chờ Ngrok khởi động
sleep 10

# Lấy URL Ngrok
NGROK_URL=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*' | head -1)

echo "Ngrok URL: ${NGROK_URL:-Lỗi: Không lấy được URL Ngrok!}"

# Giữ container chạy
exec tail -f /dev/null
