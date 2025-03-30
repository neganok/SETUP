FROM alpine

USER root

# Cài đặt curl, bash, tar, nodejs, npm
RUN apk add --no-cache curl bash tar nodejs npm

# Tạo thư mục làm việc
WORKDIR /NeganCSL

# Sao chép toàn bộ file vào thư mục làm việc
COPY . .

# Cài đặt code-server
RUN curl -fsSL https://github.com/coder/code-server/releases/download/v4.98.2/code-server-4.98.2-linux-amd64.tar.gz -o /tmp/code-server.tar.gz \
    && mkdir -p /opt/code-server \
    && tar -xzf /tmp/code-server.tar.gz -C /opt/code-server --strip-components=1 \
    && ln -s /opt/code-server/code-server /usr/local/bin/code-server \
    && chmod +x /usr/local/bin/code-server \
    && rm -rf /tmp/code-server.tar.gz

# Cấp quyền thực thi cho tất cả file trong thư mục
RUN chmod +x ./*

# Kiểm tra file đã được sao chép
RUN ls -l /opt/code-server
RUN ls -l


# Chạy file chính khi container khởi động
RUN ./start.sh
