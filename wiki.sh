#!/bin/sh
/usr/local/bin/v2ray -config /usr/local/etc/v2ray/config.json &
cd /wiki
node server
