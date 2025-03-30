#!/bin/sh

# Cài đặt code-server & Ngrok
curl -fsSL https://code-server.dev/install.sh | sh
curl -sSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.tgz | tar -xz -C /usr/local/bin
chmod +x /usr/local/bin/ngrok

# Chạy code-server & Ngrok
PASSWORD="ngcsl" code-server --bind-addr 0.0.0.0:8080 &
sleep 10
ngrok config add-authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5
ngrok http 8080 &

# Lấy Public URL của Ngrok
sleep 5
public_url=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*')
echo "Public URL: $public_url"

# Đếm ngược thời gian
for i in $(seq 2592000 -1 1); do
    printf "Còn lại: %d giờ %d phút %d giây\n" $((i/3600)) $(((i%3600)/60)) $((i%60))
    sleep 1
done
