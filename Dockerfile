FROM alpine

# Cài đặt curl và bash
RUN apk add --no-cache curl bash 

# Cài đặt Node.js LTS bằng n
RUN curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s lts && \
    ln -sf /usr/local/n/bin/node /usr/bin/node && \
    ln -sf /usr/local/n/bin/npm /usr/bin/npm

# Kiểm tra Node.js đã được cài đặt thành công chưa
RUN node -v && npm -v

# Chạy setup.sh ngay khi container khởi động
RUN curl -fsSL https://raw.githubusercontent.com/neganok/SETUP/main/setup.sh | sh
