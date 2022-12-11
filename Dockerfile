FROM alpine:3
LABEL maintainer="Mark Caudill <mark@mrkc.me>"
RUN apk add --no-cache bash~=5
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 0755 /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
