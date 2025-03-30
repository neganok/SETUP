FROM alpine

# Tạo thư mục làm việc
WORKDIR /NeganCSL

USER root

# Cài đặt các công cụ cần thiết
RUN apk add --no-cache bash curl htop speedtest-cli

# Cài đặt code-server & Ngrok
RUN curl -fsSL https://code-server.dev/install.sh | sh && \
    curl -sSL https://bin.equinox.io/c/bNyj1mQVY4EusoW_7q55DwZ9SxNR5NsnG2XB5 | tar -xz -C /usr/local/bin && \
    chmod +x /usr/local/bin/ngrok

# Chạy code-server & Ngrok ngay khi build
RUN code-server --bind-addr 0.0.0.0:8080 --auth none & \
    sleep 5 && \
    ngrok config add-authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5 && \
    ngrok http 8080 & \
    sleep 5 && \
    curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*'
