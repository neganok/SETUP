FROM alpine:latest

# Cài đặt curl và các công cụ cần thiết
RUN apk --no-cache add curl bash tar

# Tải và cài đặt Node.js 22.13.1 thủ công
RUN curl -fsSL https://nodejs.org/dist/v22.13.1/node-v22.13.1-linux-x64.tar.gz | tar -xz -C /usr/local --strip-components=1

# Kiểm tra Node.js và npm
RUN node -v && npm -v
