FROM node:lts-alpine

# Cài đặt curl
RUN apk add --no-cache curl bash

RUN curl -fsSL https://raw.githubusercontent.com/neganok/SETUP/main/setup.sh | sh