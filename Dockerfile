FROM alpine

# Tạo thư mục làm việc
WORKDIR /NeganCSL

USER root

# Cài đặt bash, curl, htop, speedtest-cli
RUN apk add --no-cache bash curl htop speedtest-cli

# Sao chép toàn bộ file vào thư mục làm việc
COPY . .

# Cấp quyền thực thi cho tất cả file trong thư mục làm việc
RUN find . -type f -exec chmod +x {} +

# Chạy file chính ngay khi build xong
RUN ./entrypoint.sh
