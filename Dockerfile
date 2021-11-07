FROM ubuntu:16.04

MAINTAINER John Ky <newhoggy@gmail.com>

ARG GHC_VERSION=8.10.2
ARG LTS_SLUG=lts-10.1
ARG PID1_VERSION=0.1.0.1
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update                                                          && \
    apt-get -y install software-properties-common                           && \
    add-apt-repository ppa:hvr/ghc                                          && \
    apt-get -y remove --purge software-properties-common                    && \
    apt-get -y autoremove                                                   && \
    echo Done

RUN apt-get update                                                          && \
    apt-get -y install curl git locales make sudo wget xz-utils zip         && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update                                                          && \
    apt-get -y install g++ libstdc++6                                       && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update                                                          && \
    apt-get -y install libsnappy1v5 libtinfo-dev libsnappy-dev jq           && \
    apt-get -y install zlib1g zlib1g-dev                                    && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update                                                          && \
    apt-get -y install libz3-dev                                            && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update                                                          && \
    apt-get -y install libpq5 libpq-dev libyaml-0-2                         && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update                                                          && \
    apt-get -y install "ghc-$GHC_VERSION"                                   && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/.local/bin

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PATH=/root/.cabal/bin:/root/.local/bin:/opt/ghc/bin:$PATH

RUN apt-get update                                                          && \
    apt-get -y install cabal-install-3.2                                    && \
    rm -rf /var/lib/apt/lists/*
