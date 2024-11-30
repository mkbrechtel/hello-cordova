FROM debian:bookworm as cordova-app

RUN apt-get update && apt-get install -y nodejs npm openjdk-17-jdk android-sdk && apt-get clean

WORKDIR /app
COPY package*.json ./
RUN npm ci --include=dev

ENV PATH="/app/node_modules/.bin:${PATH}"
RUN cordova telemetry off
COPY config.xml config.xml
COPY www/ www/

RUN cordova prepare
