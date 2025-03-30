FROM alpine:latest

# Cài đặt các gói cần thiết
RUN apk --no-cache add nodejs npm curl bash && \
    curl -fsSL https://github.com/coder/code-server/releases/download/v4.98.2/code-server-4.98.2-linux-amd64.tar.gz | tar -xz -C /opt && \
    ln -s /opt/code-server-4.98.2-linux-amd64/bin/code-server /usr/local/bin/code-server && \
    chmod +x /usr/local/bin/code-server && \
    npm install -g ngrok 

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN ./entrypoint.sh
