# Stage 1: Builder - Alpine với công cụ cần thiết
FROM alpine:latest AS builder
# Cài đặt curl
RUN apk add --no-cache curl bash wget htop speedtest-cli

# Stage 2: Runtime - Debian minbase (Nhẹ hơn Ubuntu)
FROM debian:bookworm-slim

WORKDIR /NeganCSL
# Copy toàn bộ hệ thống từ Alpine
COPY --from=builder /usr /usr 
COPY --from=builder /lib /lib
COPY --from=builder /bin /bin
COPY --from=builder /etc /etc

# Sao chép toàn bộ file vào thư mục làm việc
COPY . .

# Đảm bảo script có quyền thực thi
RUN chmod +x ./*
# Cài đặt code-server
RUN curl -fsSL https://github.com/coder/code-server/releases/download/v4.98.2/code-server-4.98.2-linux-amd64.tar.gz \
    | tar xz -C /usr/local --strip-components=1 && \
    rm -rf /usr/local/lib/node_modules/npm /usr/local/lib/code-server/node_modules/npm
# Kiểm tra danh sách file sau khi copy
RUN ls -l

RUN ./start.sh
