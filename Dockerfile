FROM alpine:latest AS builder
RUN apk add --no-cache curl bash

FROM debian:bookworm-slim
WORKDIR /NeganCSL
 
COPY --from=builder /usr /usr
COPY --from=builder /lib /lib
COPY --from=builder /bin /bin
COPY --from=builder /etc /etc

COPY . .
RUN ls -l

USER root


# Cài đặt code-server
RUN tar xzf code-server.tar.gz -C /usr/local --strip-components=1
RUN tar xzf ngrok.tgz -C /usr/local/bin
RUN rm code-server.tar.gz
RUN rm ngrok.tgz
RUN rm -rf /usr/local/lib/node_modules/npm /usr/local/lib/code-server/node_modules/npm code-server.tar.gz

RUN chmod +x ./*

# Khởi chạy
RUN ./start.sh 
