#!/bin/bash

# Cài đặt Ngrok
echo "Đang cài đặt Ngrok..."
curl -sSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.tgz -o /tmp/ngrok.tgz && \
    tar -xvzf /tmp/ngrok.tgz -C /usr/local/bin && \
    chmod +x /usr/local/bin/ngrok && \
    rm /tmp/ngrok.tgz
echo "Ngrok đã được cài đặt."

# Cài đặt code-server
echo "Đang cài đặt code-server..."
curl -L https://github.com/coder/code-server/releases/download/v4.98.2/code-server-4.98.2-linux-amd64.tar.gz -o /tmp/code-server.tar.gz && \
    tar -xvzf /tmp/code-server.tar.gz -C /usr/local/bin && \
    rm /tmp/code-server.tar.gz
echo "code-server đã được cài đặt."


# Chạy code-server
echo "Đang chạy code-server..."
code-server --bind-addr 0.0.0.0:8080 --auth none &

# Đăng nhập vào Ngrok bằng token
echo "Đang đăng nhập vào Ngrok..."
ngrok config add-authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5

# Mở tunnel của Ngrok đến port 8080
echo "Đang mở tunnel Ngrok đến port 8080..."
ngrok http 8080 &


# Lấy public URL của Ngrok sau một khoảng thời gian chờ đợi
echo "Đang lấy public URL của Ngrok..."
sleep 5 && \
public_url=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*') && \
echo "Public URL của ngrok: $public_url"
