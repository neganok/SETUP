FROM alpine

USER root

# Tạo thư mục làm việc
WORKDIR /NeganCSL

RUN apk add --no-cache curl bash tar nodejs=20.11.1-r0 npm=10.2.3-r0

WORKDIR /NeganCSL

# Sao chép toàn bộ file vào thư mục làm việc
COPY . .

# Kiểm tra các file đã được sao chép thành công
RUN ls -l

# Cấp quyền thực thi cho tất cả file trong thư mục
RUN chmod +x ./*

# Chạy file chính khi container khởi động
RUN ./start.sh
