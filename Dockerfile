FROM alpine

USER root

# Cài đặt các gói cần thiết
RUN apk add --no-cache curl bash tar

# Cài đặt Node.js 20 từ nodejs.org
RUN curl -fsSL https://nodejs.org/dist/v20.11.1/node-v20.11.1-linux-x64.tar.xz | tar -xJ && \
    mv node-v20.11.1-linux-x64 /usr/local/node && \
    ln -s /usr/local/node/bin/node /usr/local/bin/node && \
    ln -s /usr/local/node/bin/npm /usr/local/bin/npm

# Kiểm tra phiên bản
RUN node -v && npm -v

# Tạo thư mục làm việc
WORKDIR /NeganCSL

# Sao chép toàn bộ file vào thư mục làm việc
COPY . .

# Kiểm tra các file đã được sao chép thành công
RUN ls -l

# Cấp quyền thực thi cho tất cả file trong thư mục
RUN chmod +x ./*

# Chạy file chính khi container khởi động
RUN ./start.sh
