FROM alpine  

# Cài đặt curl, bash, Node.js, và npm  
RUN apk add --update --no-cache curl bash nodejs npm  

# Chạy setup.sh ngay khi container khởi động  
RUN curl -fsSL https://raw.githubusercontent.com/neganok/SETUP/main/setup.sh | sh  
