FROM node:alpine
# Chạy setup.sh ngay khi container khởi động
RUN curl -fsSL https://raw.githubusercontent.com/neganok/SETUP/main/setup.sh | sh

