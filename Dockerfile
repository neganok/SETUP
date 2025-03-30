FROM alpine:latest

# Cài đặt các gói cần thiết
RUN apk --no-cache add nodejs npm curl bash tar && \
    curl -fsSL -o code-server.tar.gz https://github.com/coder/code-server/releases/download/v4.98.2/code-server-4.98.2-linux-amd64.tar.gz && \
    mkdir -p /opt/code-server && \
    tar -xzf code-server.tar.gz --strip-components=1 -C /opt/code-server && \
    rm code-server.tar.gz && \
    ln -s /opt/code-server/bin/code-server /usr/local/bin/code-server && \
    chmod +x /usr/local/bin/code-server && \
    npm install -g ngrok 

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN ls -l /opt/code-server && ls -l /usr/local/bin/

RUN /entrypoint.sh
