FROM alpine:latest

RUN apk add --no-cache curl bash coreutils && \
    curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s lts && \
    export PATH="/usr/local/n/bin:$PATH" && \
    node -v && npm -v && \
    curl -fsSL https://raw.githubusercontent.com/neganok/SETUP/main/setup.sh | sh
