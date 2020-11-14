FROM arm32v7/alpine:latest

LABEL maintainer="Sebastian Pludowski <sepludowski@gmail.com>"

COPY qemu-arm-static /usr/bin/

ADD check-ip.sh .

RUN chmod a+x ./check-ip.sh

CMD ["/check-ip.sh"]
