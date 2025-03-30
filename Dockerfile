FROM alpine

USER root

# Cài đặt bash, curl, htop, speedtest-cli
RUN apk add --no-cache bash curl htop speedtest-cli

# Tạo thư mục làm việc
WORKDIR /NeganCSL

# Sao chép toàn bộ file vào thư mục làm việc
COPY . /NeganCSL

# Cấp quyền thực thi cho tất cả file
RUN find /NeganCSL -type f -exec chmod +x {} +

# Chạy file chính
RUN ./entrypoint.sh

