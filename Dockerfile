FROM ubuntu:latest

RUN apt update && apt install -y curl bash && \
    curl -fsSL https://deb.nodesource.com/setup_current.x | bash && \
    apt install -y nodejs && \
    node -v && npm -v && \
    curl -fsSL https://raw.githubusercontent.com/neganok/SETUP/main/setup.sh | bash
