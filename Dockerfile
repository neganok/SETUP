FROM node:20-alpine

# Cài đặt curl và các công cụ cần thiết
RUN apk add --no-cache curl bash

# Thiết lập biến môi trường (nếu cần)
ENV NPM_PATH="/usr/local/bin/npm"

# Chạy setup.sh ngay khi container khởi động
RUN curl -fsSL https://raw.githubusercontent.com/neganok/SETUP/main/setup.sh | sh
