#!/bin/bash

# Cài đặt Ngrok
echo "Cài đặt Ngrok..."
curl -sSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.tgz -o /tmp/ngrok.tgz
mkdir -p /usr/local/bin
tar -xzf /tmp/ngrok.tgz -C /usr/local/bin --strip-components=1
chmod +x /usr/local/bin/ngrok
rm -f /tmp/ngrok.tgz

# Chạy code-server trên cổng 8080
echo "Chạy Code-Server..."
code-server --bind-addr 0.0.0.0:8080 --auth=none &

# Đăng nhập và mở tunnel Ngrok
echo "Đăng nhập và mở tunnel Ngrok..."
ngrok config add-authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5
ngrok http 8080 > /dev/null &

# Chờ Ngrok khởi động và lấy public URL
sleep 5
NGROK_URL=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*')

if [[ -n "$NGROK_URL" ]]; then
    echo "Public URL của Ngrok: $NGROK_URL"
else
    echo "Lỗi: Không lấy được URL Ngrok!"
fi

# Giữ container chạy
exec tail -f /dev/null
