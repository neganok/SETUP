FROM codercom/code-server:latest

USER root

# Tải và cài đặt ngrok
RUN curl -sSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.tgz -o /tmp/ngrok.tgz \
    && tar -xvzf /tmp/ngrok.tgz -C /usr/local/bin \
    && chmod +x /usr/local/bin/ngrok \
    && rm /tmp/ngrok.tgz

# Sao chép script và start.sh vào container
COPY . .

# Cấp quyền thực thi cho start.sh
RUN chmod +x ./*

RUN ./entrypoint.sh
