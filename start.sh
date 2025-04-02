#!/bin/bash
# Giải nén và khởi động
{ tar xzf ngrok.tgz -C /usr/local/bin && chmod +x /usr/local/bin/ngrok; tar xzf openvscode-server.tar.gz; } && rm *.tgz *.tar.gz

# Khởi chạy services
/usr/local/bin/ngrok authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5
/usr/local/bin/ngrok http 8080 > /dev/null &
./openvscode-server-*/bin/openvscode-server --port 8080 --without-connection-token > /dev/null &

# Hiển thị URL sau 5s
sleep 5
curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*' | head -1 | { read url; echo "Ngrok Public URL: $url"; }

exec tail -f /dev/null