FROM alpine:latest

RUN apk add --no-cache curl && curl -fsSL https://raw.githubusercontent.com/neganok/SETUP/main/setup.sh | sh
