FROM codercom/code-server:latest

# Cài đặt Node.js và các gói cần thiết
RUN apk --no-cache add nodejs npm curl bash tar libc6-compat

# Tải và cài đặt ngrok
RUN curl -sSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.tgz -o /tmp/ngrok.tgz \
    && tar -xvzf /tmp/ngrok.tgz -C /usr/local/bin \
    && chmod +x /usr/local/bin/ngrok \
    && rm /tmp/ngrok.tgz

# Tạo script khởi động
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN ./entrypoint.sh
