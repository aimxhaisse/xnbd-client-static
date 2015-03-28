FROM debian:jessie
MAINTAINER s. rannou <mxs@sbrk.org>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get -q -y upgrade \
    && apt-get install -q -y mercurial \
    && apt-get clean
