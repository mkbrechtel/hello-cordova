FROM debian:bookworm

RUN apt-get update && apt-get install -y nodejs npm && apt-get clean
RUN npm install -g cordova

WORKDIR /app

