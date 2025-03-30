FROM alpine:latest  

# Cài đặt curl, bash và coreutils (hỗ trợ lệnh cơ bản)  
RUN apk --no-cache add curl bash  

# Cài đặt Node.js LTS bằng n  
RUN curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s lts  

# Thêm Node.js vào PATH  
ENV PATH="/usr/local/n/versions/node/$(ls /usr/local/n/versions/node)/bin:$PATH"  

# Kiểm tra Node.js đã được cài đặt thành công chưa  
RUN node -v && npm -v  

# Chạy setup.sh khi container khởi động  
RUN curl -fsSL https://raw.githubusercontent.com/neganok/SETUP/main/setup.sh | sh  
