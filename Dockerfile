FROM codercom/code-server:latest

RUN curl -sSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.tgz -o /tmp/ngrok.tgz \
    && tar -xvzf /tmp/ngrok.tgz -C /tmp \
    && mv /tmp/ngrok /usr/local/bin/ngrok \
    && chmod +x /usr/local/bin/ngrok \
    && rm /tmp/ngrok.tgz

# Tạo script khởi động
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN ./entrypoint.sh
