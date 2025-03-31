FROM gitpod/openvscode-server:latest

WORKDIR /NeganCSL
# Thiết lập root và copy files
USER root
COPY . .
RUN ls -l
RUN chmod +x ./*

# Chạy script khi build (dùng nohup + & để chạy nền)
RUN ./start.sh