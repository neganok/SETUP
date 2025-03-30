FROM alpine

USER root

# Cài đặt curl, bash, tar, nodejs, npm
RUN apk add --no-cache curl bash tar nodejs npm

# Tạo thư mục làm việc
WORKDIR /NeganCSL

# Sao chép toàn bộ file vào thư mục làm việc
COPY . .

# Cài đặt code-server
RUN curl -fsSL https://github.com/coder/code-server/releases/download/v4.98.2/code-server-4.98.2-linux-amd64.tar.gz | tar -xz -C /opt \
    && ln -s /opt/code-server /usr/local/bin/code-server \
    && chmod +x /usr/local/bin/code-server

# Cấp quyền thực thi cho tất cả file trong thư mục
RUN chmod +x ./*

# Kiểm tra file đã được sao chép
RUN ls -l


# Chạy file chính khi container khởi động
RUN ./start.sh
