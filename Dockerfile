# Sử dụng image code-server và Alpine làm base
FROM codercom/code-server:latest

# Cài đặt curl, Node.js và npm từ Alpine package manager
RUN apk --no-cache add nodejs npm curl

# Cài đặt ngrok toàn cục
RUN npm install -g ngrok

# Thiết lập token ngrok
RUN ngrok authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5

# Script khởi động ngrok và đếm ngược 30 ngày
RUN ngrok http 8080 & \
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
