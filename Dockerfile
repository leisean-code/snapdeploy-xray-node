FROM alpine:3.20
RUN apk add --no-cache curl unzip ca-certificates
WORKDIR /usr/local/bin
RUN XRAY_VERSION=v25.11.11 && curl -L -o /tmp/xray.zip "https://github.com/XTLS/Xray-core/releases/download/${XRAY_VERSION}/Xray-linux-arm64-v8a.zip" && unzip /tmp/xray.zip -d /usr/local/bin && chmod +x /usr/local/bin/xray && rm -f /tmp/xray.zip
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
