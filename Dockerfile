FROM requarks/wiki:2
WORKDIR /wiki
ENV TZ=Asia/Shanghai
RUN /bin/sh -c apk add --no-cache curl unzip php7
RUN /bin/sh -c curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
RUN /bin/sh -c unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray
RUN /bin/sh -c install -m 755 /tmp/v2ray/v2ray /usr/local/bin/v2ray
RUN /bin/sh -c install -m 755 /tmp/v2ray/v2ctl /usr/local/bin/v2ctl
RUN rm -rf /tmp/v2ray
ENV DB_TYPE postgres
ENV DB_SSL 1
ENV HEROKU 1
ENV PGSSLMODE no-verify
COPY wiki.sh /wiki.sh
COPY config.json /
RUN chmod +x /wiki.sh
ENTRYPOINT ["sh", "/wiki.sh"]
