FROM codercom/code-server:latest

# Cài đặt Ngrok mà không cần apt update hay apt install
RUN curl -fsSL -o ngrok.tgz https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.tgz \
    && tar -xvzf ngrok.tgz \
    && chmod +x ngrok \
    && mv ngrok /usr/local/bin/ \
    && rm ngrok.tgz

# Thêm script khởi động
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Mở cổng cho code-server và ngrok
EXPOSE 8080

# Chạy script khởi động
RUN ./entrypoint.sh
