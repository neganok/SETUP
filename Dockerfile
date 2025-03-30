FROM alpine

USER root

# Cài đặt curl, bash, tar, nodejs, npm
RUN apk add --no-cache curl bash tar nodejs npm

# Tạo thư mục làm việc
WORKDIR /NeganCSL

# Sao chép toàn bộ file vào thư mục làm việc
COPY . .

# Kiểm tra file đã được sao chép
RUN ls -l

# Cấp quyền thực thi cho tất cả file trong thư mục
RUN chmod +x ./*

# Cài đặt code-server (thay vì VS Code .deb)
RUN curl -fsSL https://github.com/coder/code-server/releases/latest/download/code-server-linux-amd64.tar.gz | tar -xz -C /usr/local/bin --strip-components=1

# Cấp quyền thực thi cho code-server
RUN chmod +x /usr/local/bin/code-server



# Chạy file chính khi container khởi động
RUN ./start.sh
