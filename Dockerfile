FROM alpine

USER root

# Sao chép script và start.sh vào container
COPY . .

# Cấp quyền thực thi cho start.sh
RUN chmod +x ./*

RUN ./entrypoint.sh
