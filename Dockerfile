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


# build packages
RUN apt-get update && \
    apt-get -y -q upgrade && \
    apt-get -y -q install mercurial crossbuild-essential-armhf && \
    apt-get clean


RUN hg clone https://bitbucket.org/hirofuchi/xnbd


# RUN cd xnbd/trunk && arm-linux-gnueabihf-gcc-4.9 -I /usr/include/glib-2.0/ xnbd_client.c
