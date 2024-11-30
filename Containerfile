FROM debian:bookworm as cordova-app

RUN apt-get update && apt-get install -y nodejs npm default-jdk wget unzip gradle ant sdkmanager && apt-get clean

# Set up Android SDK environment variables
ENV ANDROID_SDK_ROOT=/opt/android-sdk \
    ANDROID_HOME=/opt/android-sdk \
    PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/tools/bin

# Accept licenses and install required Android SDK packages
RUN yes | sdkmanager --sdk_root=$ANDROID_SDK_ROOT "cmdline-tools;latest" \
    && yes | sdkmanager --sdk_root=$ANDROID_SDK_ROOT "platform-tools" "platforms;android-34" \
    && yes | sdkmanager --sdk_root=$ANDROID_SDK_ROOT "build-tools;34.0.0"

WORKDIR /app
COPY package*.json ./
RUN npm ci --include=dev

ENV PATH="/app/node_modules/.bin:${PATH}"
RUN cordova telemetry off
COPY config.xml config.xml
COPY www/ www/

RUN cordova prepare
RUN cordova build android
