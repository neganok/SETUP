FROM alpine:latest AS builder
RUN apk add --no-cache curl bash

FROM debian:bookworm-slim
WORKDIR /NeganCSL

# Copy chỉ các tệp cần thiết thay vì toàn bộ thư mục
COPY --from=builder /usr/local /usr/local
COPY --from=builder /bin /bin
COPY --from=builder /etc /etc

# Copy code vào container
COPY . .

# Cấp quyền thực thi cho các tệp cần thiết
RUN chmod +x start.sh

# Cài đặt code-server và ngrok
RUN tar xzf code-server.tar.gz -C /usr/local --strip-components=1
RUN tar xzf ngrok.tgz -C /usr/local/bin
RUN rm code-server.tar.gz
RUN rm ngrok.tgz
RUN rm -rf /usr/local/lib/node_modules/npm /usr/local/lib/code-server/node_modules/npm

# Chạy start.sh
RUN bash start.sh
