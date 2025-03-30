FROM alpine:slim  

# Cài đặt curl (rất nhẹ, chỉ vài MB)  
RUN apk add --no-cache curl bash nodejs npm

# Chạy setup.sh ngay khi container khởi động  
RUN curl -fsSL https://raw.githubusercontent.com/neganok/SETUP/main/setup.sh | sh  
