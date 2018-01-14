FROM alpine:3.7

LABEL maintainer="Jeremy Gibbons <jeremy.gibbons@laposte.net>"

ENV AWS_CLI_VERSION 1.14.24

RUN apk update \
    && apk add --no-cache squid \
	&& apk --no-cache add python py-pip groff less \
	&& pip --no-cache-dir install awscli==${AWS_CLI_VERSION} \
    && rm -rf /var/cache/apk/*
	&& curl -sF https://s3.amazonaws.com/jgisquidtest/squid3.conf -o squid.conf \
	&& mv /etc/squid/squid.conf /etc/squid/squid.conf.dist \
	&& install -m644 squid.conf /etc/squid/squid.conf

COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3128/tcp

ENTRYPOINT ["/sbin/entrypoint.sh"]