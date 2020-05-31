ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION}

RUN apk update && \
    apk upgrade && \
    apk --no-cache add pptpd ppp && \
    rm -rf /var/cache/apk/* && \
    rm -f /etc/pptpd.conf && \
    rm -f /etc/ppp/chap-secrets
EXPOSE 1723/tcp
CMD pptpd && syslogd -n -O /dev/stdout



ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="PPTP Server" \
      org.label-schema.description="Alpine-based PPTP server" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/alexswilliams/pptp-server-docker" \
      org.label-schema.schema-version="1.0"
