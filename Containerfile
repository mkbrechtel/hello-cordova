FROM debian:bookworm as env

RUN apt-get update && apt-get install -y nodejs yarnpkg && apt-get clean

WORKDIR /app
COPY package.json yarn.lock ./
RUN yarnpkg install --frozen-lockfile
ENV PATH="/app/node_modules/.bin:${PATH}"
RUN cordova telemetry off
RUN cordova platform add browser

FROM env as build

COPY cordova.config.xml ./
COPY www/ www/
