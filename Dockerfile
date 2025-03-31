FROM alpine:latest AS builder
USER root
RUN apk add --no-cache curl bash tar

WORKDIR /NeganCSL
COPY . .

# Cài đặt code-server
RUN tar xzf code-server.tar.gz -C /usr/local --strip-components=1
RUN tar xzf ngrok.tgz -C /usr/local/bin
RUN rm code-server.tar.gz ngrok.tgz
RUN chmod +x ./*

# Lưu các file cần thiết
RUN mkdir /tmp/build
RUN cp -r /usr/local /tmp/build/
RUN cp -r /NeganCSL /tmp/build/

# ==========================================

FROM debian:bookworm-slim

USER root
WORKDIR /NeganCSL

# Chỉ copy các file thực sự cần
COPY --from=builder /tmp/build/usr/local /usr/local
COPY --from=builder /tmp/build/NeganCSL /NeganCSL

# Liệt kê file để debug
RUN ls -l /NeganCSL

RUN chmod +x ./*

# Khởi chạy
RUN ./start.sh 