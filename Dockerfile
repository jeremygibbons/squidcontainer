FROM alpine:3.7

LABEL maintainer="Jeremy Gibbons <jeremy.gibbons@laposte.net>"

ENV AWS_CLI_VERSION 1.14.24
ENV SQUID_VERSION 3.5.23
ENV SQUID_CACHE_DIR /var/spool/squid
ENV SQUID_LOG_DIR /var/log/squid
ENV SQUID_USER squid

RUN mkdir -p ${SQUID_LOG_DIR} \
  && chmod -R 755 ${SQUID_LOG_DIR} \
  && chown -R ${SQUID_USER}:${SQUID_USER} ${SQUID_LOG_DIR}
  && ln -sf /proc/1/fd/1 ${SQUID_LOG_DIR}/access.log

RUN apk update \
    && apk add --no-cache squid \
	&& apk --no-cache add python py-pip groff less \
	&& pip --no-cache-dir install awscli==${AWS_CLI_VERSION} \
    && rm -rf /var/cache/apk/* \
	&& wget -q https://s3.amazonaws.com/jgisquidtest/squid3.conf -O squid.conf \
	&& mv /etc/squid/squid.conf /etc/squid/squid.conf.dist \
	&& install -m644 squid.conf /etc/squid/squid.conf

COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 8080/tcp

ENTRYPOINT ["/sbin/entrypoint.sh"]
