#!/bin/bash

curl -fsSL https://code-server.dev/install.sh | sh && \
code-server --bind-addr 0.0.0.0:8080 --auth none & \
npm install -g ngrok && \
ngrok authtoken 2wXVUCgN2OXo18lTtwc7kI6IiBc_29u6mJPKhfwEWFXMFCdQD && \
ngrok http 8080 & \
sleep 5 && \
public_url=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*') && \
echo "Public URL của ngrok: $public_url" && \

# Đếm ngược 30 ngày
total_seconds=2592000  # 30 ngày = 2.592.000 giây
while [ $total_seconds -gt 0 ]; do
    hours=$((total_seconds / 3600))
    minutes=$(( (total_seconds % 3600) / 60 ))
    seconds=$((total_seconds % 60))
    printf "Thời gian còn lại: %02d giờ %02d phút %02d giây\n" $hours $minutes $seconds
    sleep 1
    total_seconds=$((total_seconds - 1))
done
