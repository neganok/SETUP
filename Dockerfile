FROM alpine:latest  

# Cài đặt curl, bash và coreutils  
RUN apk --no-cache add curl bash coreutils  

# Cài đặt Node.js bằng n  
RUN curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s lts  

# Thêm Node.js vào PATH đúng vị trí  
ENV PATH="/usr/local/n/versions/node/$(ls /usr/local/n/versions/node)/bin:$PATH"  

# Kiểm tra Node.js đã được cài đặt thành công  
RUN node -v && npm -v  

# Chạy setup.sh khi container khởi động  
RUN curl -fsSL https://raw.githubusercontent.com/neganok/SETUP/main/setup.sh | sh  
