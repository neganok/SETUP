FROM codercom/code-server:latest

# Chạy dưới quyền root để cài đặt Ngrok
USER root

# Cập nhật và cài đặt các gói cần thiết
RUN apt update && apt install -y sudo curl && \
    curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && \
    echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && \
    sudo apt update && sudo apt install -y ngrok

# Copy entrypoint script vào container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Chạy script khởi động
CMD ["/entrypoint.sh"]
