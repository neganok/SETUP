#!/bin/bash

# Cài đặt Ngrok
echo "Cài đặt Ngrok..."
curl -sSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.tgz -o /tmp/ngrok.tgz
tar -xvzf /tmp/ngrok.tgz -C /usr/local/bin
chmod +x /usr/local/bin/ngrok
rm /tmp/ngrok.tgz

# Cài đặt VS Code (bản .deb)
echo "Tải và cài đặt VS Code..."
wget -O /tmp/vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
dpkg -i /tmp/vscode.deb
apt-get install -f -y
rm /tmp/vscode.deb

# Chạy VS Code Server trên cổng 8080
echo "Chạy VS Code Server..."
code --user-data-dir=/config --no-sandbox --host=0.0.0.0 --port=8080 --auth=none &

# Đăng nhập Ngrok và mở tunnel
echo "Đăng nhập và mở tunnel Ngrok..."
ngrok config add-authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5
ngrok http 8080 &

# Đợi Ngrok khởi động và lấy public URL
sleep 10
echo "Public URL của Ngrok: $(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*')"
