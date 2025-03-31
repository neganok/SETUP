FROM alpine:3.18

RUN apk add --no-cache curl tar && \
    curl -L https://github.com/gitpod-io/openvscode-server/releases/download/openvscode-server-v1.98.0/openvscode-server-v1.98.0-linux-x64.tar.gz -o vscode.tar.gz && \
    tar xzf vscode.tar.gz -C /opt && \
    mv /opt/openvscode-server-* /opt/vscode && \
    rm vscode.tar.gz

# Chạy thử nghiệm ngay khi build (container sẽ dừng sau khi build)
RUN /opt/vscode/bin/openvscode-server --version  # Kiểm tra phiên bản