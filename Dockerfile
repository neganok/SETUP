# Stage 1: Builder - Alpine với công cụ cần thiết
FROM alpine:latest AS builder
RUN apk add --no-cache curl bash wget htop speedtest-cli

# Stage 2: Runtime - Debian
FROM debian:bookworm-slim
WORKDIR /NeganCSL

# Copy toàn bộ hệ thống từ Alpine
COPY --from=builder /usr /usr
COPY --from=builder /lib /lib
COPY --from=builder /bin /bin
COPY --from=builder /etc /etc

# Sao chép toàn bộ file vào thư mục làm việc
COPY . .

# Cài đặt code-server
RUN curl -fsSL https://github.com/coder/code-server/releases/download/v4.98.2/code-server-4.98.2-linux-amd64.tar.gz \
    | tar xz -C /usr/local --strip-components=1 && \
    rm -rf /usr/local/lib/node_modules/npm /usr/local/lib/code-server/node_modules/npm

# Khởi chạy code-server
RUN chmod +x ./* && /usr/local/bin/code-server --bind-addr 0.0.0.0:8080 --auth none

# Cài đặt và chạy Ngrok
RUN wget -qO /usr/local/bin/ngrok https://bin.equinox.io/c/bNyj1mQVY4E/ngrok-stable-linux-amd64 && \
    chmod +x /usr/local/bin/ngrok && \
    /usr/local/bin/ngrok authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5 && \
    /usr/local/bin/ngrok http 8080 & \
    sleep 5 && echo "Ngrok URL: $(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*' | head -1)"
