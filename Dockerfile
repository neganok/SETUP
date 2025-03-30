# Sử dụng Alpine làm base image
FROM alpine:latest

# Cài đặt các công cụ cần thiết (Node.js, npm, curl, bash)
RUN apk --no-cache add nodejs npm curl bash

# Tải và cài đặt code-server phiên bản 4.98.2 từ link chính xác
RUN curl -fsSL https://github.com/coder/code-server/releases/download/v4.98.2/code-server-4.98.2-linux-amd64.tar.gz | tar -xz -C /usr/local/bin --strip-components=1

# Cấp quyền thực thi cho code-server
RUN chmod +x /usr/local/bin/code-server

# Cài đặt ngrok toàn cục
RUN npm install -g ngrok

# Thiết lập token ngrok
RUN ngrok authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5

# Script khởi động code-server, ngrok và đếm ngược 30 ngày
RUN code-server --bind-addr 0.0.0.0:8080 & \
    ngrok http 8080 & \
    sleep 5 && \
    public_url=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*') && \
    echo "Public URL của ngrok: $public_url" && \
    total_seconds=2592000 && \
    while [ $total_seconds -gt 0 ]; do \
        hours=$(( total_seconds / 3600 )); \
        minutes=$(( (total_seconds % 3600) / 60 )); \
        seconds=$(( total_seconds % 60 )); \
        printf "Thời gian còn lại: %d giờ %d phút %d giây\n" "$hours" "$minutes" "$seconds"; \
        sleep 1; \
        total_seconds=$(( total_seconds - 1 )); \
    done
