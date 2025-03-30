#!/bin/sh

# Cài đặt code-server
curl -fsSL https://code-server.dev/install.sh | sh 

# Kiểm tra xem code-server có được cài thành công không
if ! command -v code-server &> /dev/null; then
    echo "Lỗi: code-server chưa được cài đặt thành công!"
    exit 1
fi

# Chạy code-server với mật khẩu "ngcsl"
PASSWORD="ngcsl" /usr/bin/code-server --bind-addr 0.0.0.0:8080 &

# Đăng nhập Ngrok
ngrok config add-authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5

# Đợi code-server khởi động
sleep 10

# Chạy Ngrok
ngrok http 8080 &

# Đợi Ngrok khởi động
sleep 5

# Lấy Public URL của Ngrok
public_url=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*')
echo "Public URL của Ngrok: $public_url"

# Chạy vòng lặp đếm thời gian
total_seconds=2592000
while [ $total_seconds -gt 0 ]; do
    hours=$(( total_seconds / 3600 ))
    minutes=$(( (total_seconds % 3600) / 60 ))
    seconds=$(( total_seconds % 60 ))
    printf "Thời gian còn lại: %d giờ %d phút %d giây\n" "$hours" "$minutes" "$seconds"
    sleep 1
    total_seconds=$(( total_seconds - 1 ))
done
