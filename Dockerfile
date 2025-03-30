FROM alpine

USER root

# Cài đặt bash, curl, htop, speedtest-cli
RUN apk add --no-cache bash curl htop speedtest-cli

# Sao chép tất cả script vào container
COPY . .

# Cấp quyền thực thi cho start.sh
RUN chmod +x ./*

# Cấp quyền thực thi cho tất cả script
RUN ./entrypoint.sh
