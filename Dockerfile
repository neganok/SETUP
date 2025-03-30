FROM alpine

USER root

# Cài đặt bash, curl, htop, speedtest-cli
RUN apk add --no-cache bash curl htop speedtest-cli

# Sao chép toàn bộ file vào thư mục làm việc
COPY . .

# Cấp quyền thực thi cho file entrypoint
RUN chmod +x entrypoint.sh

# Chạy file chính khi container khởi động
RUN ./entrypoint.sh
