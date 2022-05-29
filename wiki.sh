#!/bin/sh
/usr/local/bin/v2ray -config /config.json &
cd /wiki
node server
