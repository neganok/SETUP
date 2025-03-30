#!/bin/bash

# Cài đặt Ngrok
curl -sSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.tgz -o /tmp/ngrok.tgz && \
    tar -xvzf /tmp/ngrok.tgz -C /usr/local/bin && \
    chmod +x /usr/local/bin/ngrok && rm /tmp/ngrok.tgz

# Tải và giải nén code-server vào thư mục /usr/local
curl -sSL https://github.com/coder/code-server/releases/download/v4.98.2/code-server-4.98.2-linux-amd64.tar.gz -o /tmp/code-server.tar.gz && \
    tar -xvzf /tmp/code-server.tar.gz -C /usr/local && \
    rm /tmp/code-server.tar.gz

# Kiểm tra thư mục giải nén và liệt kê nội dung
echo "Kiểm tra thư mục giải nén code-server..."
ls -l /usr/local/code-server-4.98.2-linux-amd64/

# Kiểm tra nếu thư mục code-server có tồn tại
if [ -d "/usr/local/code-server-4.98.2-linux-amd64" ]; then
    echo "Thư mục code-server đã tồn tại."
    # Liệt kê tất cả các tệp trong thư mục để tìm tệp chính
    ls -l /usr/local/code-server-4.98.2-linux-amd64/
else
    echo "Lỗi: Thư mục giải nén code-server không tồn tại."
    exit 1
fi

# Kiểm tra nếu tệp code-server có tồn tại
if [ -f "/usr/local/code-server-4.98.2-linux-amd64/code-server" ]; then
    # Di chuyển tệp code-server vào thư mục thích hợp và cấp quyền thực thi
    mv /usr/local/code-server-4.98.2-linux-amd64/code-server /usr/local/bin/ && \
    chmod +x /usr/local/bin/code-server
else
    echo "Lỗi: Tệp 'code-server' không tồn tại trong thư mục giải nén."
    exit 1
fi

# Kiểm tra nếu tệp code-server đã được di chuyển thành công
echo "Kiểm tra tệp code-server đã được di chuyển chưa..."
ls -l /usr/local/bin/code-server

# Chạy code-server nếu tệp đã có mặt
if [ -f "/usr/local/bin/code-server" ]; then
    echo "Khởi động code-server..."
    code-server --bind-addr 0.0.0.0:8080 --auth none &
else
    echo "Lỗi: Không thể tìm thấy tệp 'code-server' để khởi động."
    exit 1
fi

# Cài đặt ngrok và đăng nhập
ngrok config add-authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5 && \
ngrok http 8080 &

# Lấy public URL của ngrok
sleep 5 && \
public_url=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*') && \
echo "Public URL của ngrok: $public_url"
