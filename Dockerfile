FROM arm32v7/alpine:3.12.7

LABEL maintainer="Sebastian Pludowski <sepludowski@gmail.com>"

COPY qemu-arm-static /usr/bin/

RUN apk --no-cache add bash curl coreutils grep

ADD check_ip.sh /opt

RUN chmod a+x /opt/check_ip.sh

CMD ["/opt/check_ip.sh"]
