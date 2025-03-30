FROM node:20-alpine

# Cài đặt curl
RUN apk add --no-cache curl

# Chạy setup.sh ngay khi container khởi động
RUN curl -fsSL https://raw.githubusercontent.com/neganok/SETUP/main/setup.sh | sh
