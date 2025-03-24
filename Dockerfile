FROM alpine:latest

RUN apk add --no-cache curl bash && \
    curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s lts && \
    curl -fsSL https://raw.githubusercontent.com/neganok/SETUP/main/setup.sh | sh
