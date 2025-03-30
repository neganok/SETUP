FROM alpine

# Cài đặt curl, bash và coreutils (hỗ trợ lệnh cơ bản)
RUN apk add --no-cache curl bash coreutils

# Cài đặt Node.js LTS bằng n
RUN curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s lts

# Đảm bảo Node.js đã được cài đặt thành công
RUN node -v && npm -v

# Chạy setup.sh ngay khi container khởi động
RUN curl -fsSL https://raw.githubusercontent.com/neganok/SETUP/main/setup.sh | sh
