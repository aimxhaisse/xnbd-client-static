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


# Let's build
RUN cd xnbd/trunk && \
    arm-linux-gnueabihf-gcc-4.9 -c \
        -std=c99 -I/usr/lib/arm-linux-gnueabihf/glib-2.0/include -I/usr/include/glib-2.0 \
        -static xnbd_client.c xnbd_common.c lib/*.c \
    && arm-linux-gnueabihf-gcc-4.9 -static *.o -pthread /usr/lib/arm-linux-gnueabihf/libglib-2.0.a -o /xnbd-client-static


# Strip binary
RUN cp /xnbd-client-static /xnbd-client-static-stripped \
   && /usr/arm-linux-gnueabihf/bin/strip /xnbd-client-static-stripped
