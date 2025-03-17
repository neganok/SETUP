#!/bin/bash
# Cài đặt code-server
curl -fsSL https://code-server.dev/install.sh | sh

# Chạy code-server trên port 8080 (chạy nền)
code-server --bind-addr 0.0.0.0:8080 --auth none &

# Cài đặt ngrok toàn cục
npm install -g ngrok

# Cấu hình ngrok authtoken
ngrok authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5

# Chạy ngrok để chuyển tiếp port 8080 (chạy nền)
ngrok http 8080 &

# Đợi ngrok khởi động
sleep 5

# Lấy Public URL từ ngrok
public_url=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*')
echo "Public URL của ngrok: $public_url"

# Đếm ngược 30 ngày (30 ngày = 2,592,000 giây)
total_seconds=2592000

while [ $total_seconds -gt 0 ]; do
    hours=$(( total_seconds / 3600 ))
    minutes=$(( (total_seconds % 3600) / 60 ))
    seconds=$(( total_seconds % 60 ))
    printf "Thời gian còn lại: %d giờ %d phút %d giây\n" "$hours" "$minutes" "$seconds"
    sleep 1
    total_seconds=$(( total_seconds - 1 ))
done
