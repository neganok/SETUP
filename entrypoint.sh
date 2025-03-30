#!/bin/bash

# Cài đặt Ngrok và Node.js LTS
curl -sSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.tgz -o /tmp/ngrok.tgz && \
    tar -xvzf /tmp/ngrok.tgz -C /usr/local/bin && \
    chmod +x /usr/local/bin/ngrok && rm /tmp/ngrok.tgz && \
    curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s lts

# Cài đặt code-server
curl -fsSL https://code-server.dev/install.sh | sh && \
code-server --bind-addr 0.0.0.0:8080 --auth none &

# Cài đặt ngrok và đăng nhập
ngrok config add-authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5 && \
ngrok http 8080 &

# Lấy public URL của ngrok
sleep 5 && \
public_url=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*') && \
echo "Public URL của ngrok: $public_url"
