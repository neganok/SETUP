#!/bin/bash

# Cài đặt Ngrok
echo "Cài đặt Ngrok..."
curl -sSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.tgz -o /tmp/ngrok.tgz && \
    tar -xvzf /tmp/ngrok.tgz -C /usr/local/bin && \
    chmod +x /usr/local/bin/ngrok && rm /tmp/ngrok.tgz

# Cài đặt code-server
echo "Cài đặt code-server..."
curl -fsSL https://github.com/coder/code-server/releases/download/v4.98.2/code-server-4.98.2-linux-amd64.tar.gz -o /tmp/code-server.tar.gz

# Giải nén và cài đặt code-server vào /usr/local/bin
tar -xvzf /tmp/code-server.tar.gz -C /usr/local/bin --strip-components=1
chmod +x /usr/local/bin/code-server
rm /tmp/code-server.tar.gz

# Đảm bảo code-server có thể chạy
echo "Đảm bảo code-server có thể chạy..."
if ! command -v code-server &> /dev/null; then
    echo "code-server không tìm thấy trong PATH. Kiểm tra lại việc cài đặt."
    exit 1
fi

# Đăng nhập Ngrok và mở tunnel
echo "Đăng nhập và mở tunnel Ngrok..."
ngrok config add-authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5
ngrok http 8080 &

# Chạy code-server
echo "Chạy code-server..."
/usr/local/bin/code-server --bind-addr 0.0.0.0:8080 --auth none &

# Lấy public URL của Ngrok
echo "Public URL của Ngrok: $(sleep 5 && curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*')"
