FROM codercom/code-server:latest

# Cập nhật và cài đặt Ngrok
USER root
RUN apt update && apt install -y curl && \
    curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && \
    echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | tee /etc/apt/sources.list.d/ngrok.list && \
    apt update && apt install -y ngrok

# Copy entrypoint.sh vào container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Chạy entrypoint khi container khởi động
CMD ["/entrypoint.sh"]
