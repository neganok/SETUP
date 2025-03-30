FROM alpine

# Cài đặt curl, bash và coreutils (hỗ trợ lệnh cơ bản)
RUN apk add --no-cache curl bash 

# Cài đặt Node.js LTS bằng n
RUN curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s lts

# Chạy setup.sh ngay khi container khởi động
RUN curl -fsSL https://raw.githubusercontent.com/neganok/SETUP/main/setup.sh | sh
