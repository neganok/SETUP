FROM alpine:latest AS builder
USER root
RUN apk add --no-cache curl bash tar nodejs -g npm 
RUN npm install -global npm


COPY . .
RUN ls -l

# Cài đặt code-server
RUN tar xzf code-server.tar.gz -C /usr/local --strip-components=1
RUN tar xzf ngrok.tgz -C /usr/local/bin
RUN rm code-server.tar.gz
RUN rm ngrok.tgz
RUN rm -rf /usr/local/lib/node_modules/npm /usr/local/lib/code-server/node_modules/npm code-server.tar.gz

RUN chmod +x start.sh

# Khởi chạy
RUN ./start.sh 
