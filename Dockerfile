FROM ubuntu:vivid
MAINTAINER s. rannou <mxs@sbrk.org>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -y -q upgrade && \
    apt-get -y -q install gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf binutils-arm-linux-gnueabihf mercurial && \
    apt-get clean

RUN hg clone https://bitbucket.org/hirofuchi/xnbd && \
    cd xnbd/trunk
