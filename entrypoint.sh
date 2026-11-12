#!/bin/sh
set -e
PORT=${PORT:-8080}
UUID=${UUID:?UUID env var is required}
WSPATH=${WSPATH:-/xray}
cat > /config.json <<EOF
{
  "log": {"loglevel": "warning"},
  "inbounds": [
    {
      "port": $PORT,
      "protocol": "vless",
      "settings": {"clients": [{"id": "$UUID"}], "decryption": "none"},
      "streamSettings": {"network": "xhttp", "xhttpSettings": {"path": "$WSPATH", "mode": "packet-up"}}
    }
  ],
  "outbounds": [{"protocol": "freedom"}]
}
EOF
exec /usr/local/bin/xray run -c /config.json
