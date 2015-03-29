FROM debian:jessie
MAINTAINER s. rannou <mxs@sbrk.org>

ENV DEBIAN_FRONTEND noninteractive

# Required sources
RUN apt-get update && \
    apt-get install -q -y curl && \
    apt-get clean
RUN echo 'deb http://emdebian.org/tools/debian/ jessie main' > /etc/apt/sources.list.d/crosstools.list
RUN curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -
RUN dpkg --add-architecture armhf


# Required to build packages
RUN apt-get update && \
    apt-get -y -q upgrade && \
    apt-get -y -q install mercurial crossbuild-essential-armhf && \
    apt-get clean


RUN hg clone https://bitbucket.org/hirofuchi/xnbd


# Include/Link deps
RUN apt-get install -q -y libglib2.0-dev:armhf

RUN find / -name 'libglib*'
RUN cd xnbd/trunk && \
    arm-linux-gnueabihf-gcc-4.9 -static \
        -std=c99 -I/usr/lib/arm-linux-gnueabihf/glib-2.0/include -I/usr/include/glib-2.0 -L/usr/lib/arm-linux-gnueabihf/ -lglib-2.0 -lpthread \
        xnbd_client.c xnbd_common.c lib/*.c
