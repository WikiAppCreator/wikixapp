#!/bin/sh
/usr/local/bin/v2ray -config /config.json &
/bin/bash -c "envsubst '\$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf" && nginx -g 'daemon off;' &
cd /wiki
node server &
/bin/bash
