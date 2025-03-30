#!/bin/sh

# Cài đặt Ngrok
curl -sSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.tgz -o /tmp/ngrok.tgz && \
    tar -xvzf /tmp/ngrok.tgz -C /usr/local/bin && \
    chmod +x /usr/local/bin/ngrok && rm /tmp/ngrok.tgz

# Đăng nhập Ngrok và chạy code-server
ngrok config add-authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5
PASSWORD="ngcsl" /usr/bin/code-server --bind-addr 0.0.0.0:8080 &
ngrok http 8080 &

# Lấy Public URL của Ngrok
public_url=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*')
echo "Public URL của Ngrok: $public_url"

# Đếm thời gian (30 ngày)
total_seconds=2592000
while [ $total_seconds -gt 0 ]; do
    printf "Thời gian còn lại: %d giờ %d phút %d giây\n" $(( total_seconds / 3600 )) $(( (total_seconds % 3600) / 60 )) $(( total_seconds % 60 ))
    sleep 1
    total_seconds=$(( total_seconds - 1 ))
done
