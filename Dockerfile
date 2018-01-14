FROM alpine:3.7

LABEL maintainer="Jeremy Gibbons <jeremy.gibbons@laposte.net>"

RUN apk update \
    && apk add --no-cache squid aws-cli \
	&& curl -sF https://s3.amazonaws.com/jgisquidtest/squid3.conf -o squid.conf \
	&& mv /etc/squid/squid.conf /etc/squid/squid.conf.dist \
	&& install -m644 squid.conf /etc/squid/squid.conf

COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3128/tcp

ENTRYPOINT ["/sbin/entrypoint.sh"]