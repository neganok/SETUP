FROM alpine:latest

RUN apk add --no-cache curl bash coreutils && \
    curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s lts && \
    ln -sf /usr/local/n/versions/node/*/bin/node /usr/local/bin/node && \
    ln -sf /usr/local/n/versions/node/*/bin/npm /usr/local/bin/npm && \
    node -v && npm -v && \
    curl -fsSL https://raw.githubusercontent.com/neganok/SETUP/main/setup.sh | sh
