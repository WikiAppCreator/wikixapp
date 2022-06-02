FROM requarks/wiki:2
USER root
#ARG http_proxy=http://172.17.0.1:8889
#ARG https_proxy=http://172.17.0.1:8889
WORKDIR /
ENV TZ=Asia/Shanghai
RUN apk add --no-cache --virtual .build-deps curl unzip nginx
RUN curl -L -H "Cache-Control: no-cache" -o /v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
RUN unzip /v2ray.zip -d /v2ray
RUN install -m 755 /v2ray/v2ray /usr/local/bin/v2ray
RUN install -m 755 /v2ray/v2ctl /usr/local/bin/v2ctl
RUN rm -rf /v2ray
ENV DB_TYPE postgres
ENV DB_SSL 1
ENV HEROKU 1
ENV PGSSLMODE no-verify
#COPY nginx/default.conf.template /etc/nginx/conf.d/default.conf
COPY default.conf.template /etc/nginx/conf.d/default.conf.template
COPY nginx.conf /etc/nginx/nginx.conf
COPY wiki.sh /wiki.sh
COPY config.json /
RUN chmod +x /wiki.sh
ENTRYPOINT ["sh", "/wiki.sh"]
