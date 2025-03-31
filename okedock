FROM alpine
RUN apk add --no-cache bash curl 
# Copy mã nguồn
COPY . .

# Cài đặt code-server và ngrok
RUN tar xzf code-server.tar.gz -C /usr/local --strip-components=1 && \
    tar xzf ngrok.tgz -C /usr/local/bin && \
    rm *.tar.gz && \
    chmod +x start.sh
    
RUN ./start.sh