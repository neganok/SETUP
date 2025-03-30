# Chọn image nhẹ nhất có Node.js và cài thêm curl, bash, tar
FROM alpine

# Chạy với quyền root
USER root

# Cài đặt curl, bash và tar mà không lưu cache
RUN apk add --no-cache curl bash tar

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
