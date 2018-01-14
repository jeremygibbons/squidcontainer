FROM alpine:3.7

LABEL maintainer="Jeremy Gibbons <jeremy.gibbons@laposte.net>"

RUN apk update \
    && apk add --no-cache squid aws-cli \
	&& curl -sF https://s3.amazonaws.com/jgisquidtest/squid3.conf -o squid.conf \
	&& mv /etc/squid/squid.conf /etc/squid/squid.conf.dist 

COPY squid.conf /etc/squid/squid.conf
	
	