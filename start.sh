#!/usr/bin/env bash
#!/bin/bash

# Khởi chạy code-server
/usr/local/bin/code-server --bind-addr 0.0.0.0:8080 --auth none &

# Đợi code-server khởi động
sleep 5

# Thiết lập authtoken cho ngrok
/usr/local/bin/ngrok authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5

# Khởi chạy ngrok
/usr/local/bin/ngrok http 8080 &

# Đợi ngrok khởi động
sleep 5 

# Lấy và hiển thị public URL
echo "Ngrok Public URL: $(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*' | head -1)"

# Giữ container chạy
exec tail -f /dev/null  
 
