FROM alpine

USER root

# Thêm kho lưu trữ cộng đồng, cập nhật danh sách gói
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache curl bash tar nodejs=20.11.1-r0 npm=10.2.3-r0

# Kiểm tra phiên bản Node.js và npm
RUN node -v && npm -v


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
