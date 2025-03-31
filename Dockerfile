FROM alpine:latest AS builder
RUN apk add --no-cache curl bash wget

FROM debian:bookworm-slim
WORKDIR /NeganCSL

COPY --from=builder /usr /usr
COPY --from=builder /lib /lib
COPY --from=builder /bin /bin
COPY --from=builder /etc /etc

COPY . .

# Cài đặt code-server
RUN curl -fsSL https://github.com/coder/code-server/releases/download/v4.98.2/code-server-4.98.2-linux-amd64.tar.gz -o code-server.tar.gz
RUN tar xzf code-server.tar.gz -C /usr/local --strip-components=1
RUN rm -rf /usr/local/lib/node_modules/npm /usr/local/lib/code-server/node_modules/npm code-server.tar.gz

# Cài đặt Ngrok
RUN wget -q https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.tgz -O ngrok.tgz
RUN tar xzf ngrok.tgz -C /usr/local/bin
RUN chmod +x /usr/local/bin/ngrok
RUN rm ngrok.tgz

RUN chmod +x ./*

# Khởi chạy
RUN /start.sh
