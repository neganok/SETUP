#!/bin/sh

# Cài đặt code-server & Ngrok
curl -fsSL https://code-server.dev/install.sh | sh 
curl -sSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.tgz | tar -xz -C /usr/local/bin

# Kiểm tra cài đặt
command -v code-server >/dev/null || { echo "Lỗi: code-server chưa được cài đặt!"; exit 1; }
command -v ngrok >/dev/null || { echo "Lỗi: Ngrok chưa được cài đặt!"; exit 1; }

# Chạy code-server & Ngrok
code-server --bind-addr 0.0.0.0:8080 --auth none & 
sleep 10
ngrok config add-authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5
ngrok http 8080 &

# Lấy Public URL của Ngrok
sleep 5
public_url=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*')
echo "Public URL: $public_url"

# Đếm ngược thời gian
total_seconds=2592000
while [ $total_seconds -gt 0 ]; do
    printf "Còn lại: %d giờ %d phút %d giây\n" $((total_seconds/3600)) $(((total_seconds%3600)/60)) $((total_seconds%60))
    sleep 1
    total_seconds=$((total_seconds - 1))
done
