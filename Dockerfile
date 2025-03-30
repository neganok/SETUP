# Chọn Alpine Linux làm base image
FROM alpine:latest

# Chạy với quyền root
USER root

# Cài đặt các gói cần thiết
RUN apk add --no-cache curl bash tar dpkg wget

# Tạo thư mục làm việc
WORKDIR /NeganCSL

# Sao chép toàn bộ file vào thư mục làm việc
COPY . .

# Kiểm tra các file đã được sao chép thành công
RUN ls -l

# Cấp quyền thực thi cho tất cả file trong thư mục
RUN chmod +x ./*

# Chạy file chính khi container khởi động
RUN ./start.sh
