FROM alpine:3.5

RUN apk add --no-cache curl jq ssmtp mailx

COPY docker-entrypoint /
ENTRYPOINT ["/docker-entrypoint"]

HEALTHCHECK --interval=5s CMD exit 0

CMD ["autoheal"]
