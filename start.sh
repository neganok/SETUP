#!/bin/bash

# Cài đặt Ngrok
echo "Cài đặt Ngrok..."
curl -sSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.tgz -o /tmp/ngrok.tgz
tar -xvzf /tmp/ngrok.tgz -C /usr/local/bin
chmod +x /usr/local/bin/ngrok
rm /tmp/ngrok.tgz

# Cài đặt Code-Server
echo "Cài đặt Code-Server..."
curl -fsSL https://code-server.dev/install.sh | sh

# Chạy Code-Server
echo "Chạy Code-Server trên cổng 8080..."
code-server --bind-addr 0.0.0.0:8080 --auth none &

# Đăng nhập Ngrok và mở tunnel
echo "Đăng nhập và mở tunnel Ngrok..."
ngrok config add-authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5
ngrok http 8080 &

# Đợi Ngrok khởi động và lấy public URL
sleep 10
echo "Public URL của Ngrok: $(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*')"
