FROM alpine:latest

RUN apk add --no-cache curl nodejs npm && curl -fsSL https://raw.githubusercontent.com/neganok/SETUP/main/setup.sh | sh
