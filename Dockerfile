FROM alpine:latest

RUN apk add --no-cache curl bash && \
    curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s lts && \
    ln -s /usr/local/n/bin/node /usr/local/bin/node && \
    curl -fsSL https://raw.githubusercontent.com/neganok/SETUP/main/setup.sh | sh
