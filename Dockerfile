FROM ubuntu:16.04

MAINTAINER John Ky <newhoggy@gmail.com>

ARG GHC_VERSION=8.10.7
ARG LTS_SLUG=lts-18.15
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

RUN curl -L http://dl.john-ky.io.s3-website-ap-southeast-2.amazonaws.com/public/haskell/downloads/cabal-cache/cabal-3.2.0.0-ubuntu-18.04.tar.gz -o cabal-3.2.0.0-ubuntu-18.04.tar.gz  && \
    tar -zxvf cabal-3.2.0.0-ubuntu-18.04.tar.gz                             && \
    mv ./cabal /root/.local/bin/cabal                                       && \
    rm cabal-3.2.0.0-ubuntu-18.04.tar.gz
