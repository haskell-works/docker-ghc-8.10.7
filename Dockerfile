FROM ubuntu:16.04

MAINTAINER John Ky <newhoggy@gmail.com>

ARG GHC_VERSION=8.10.7
ARG LTS_SLUG=lts-18.15
ARG PID1_VERSION=0.1.0.1
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update                                                          && \
    apt-get -y install curl git locales make sudo wget xz-utils zip         && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update                                                          && \
    apt-get -y install g++ libstdc++6                                       && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update                                                          && \
    apt-get -y install libsnappy1v5 libtinfo-dev libsnappy-dev jq           && \
    apt-get -y install zlib1g zlib1g-dev libgmp3-dev                        && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update                                                          && \
    apt-get -y install libz3-dev                                            && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update                                                          && \
    apt-get -y install libpq5 libpq-dev libyaml-0-2                         && \
    rm -rf /var/lib/apt/lists/*

RUN BOOTSTRAP_HASKELL_NONINTERACTIVE=true \
    BOOTSTRAP_HASKELL_GHC_VERSION="$GHC_VERSION" \
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh && \
    rm -rf /root/.ghcup/ghc/$GHC_VERSION/share/doc/ghc-$GHC_VERSION/html/users_guide \
    rm -rf /root/.ghcup/ghc/$GHC_VERSION/share/doc/ghc-$GHC_VERSION/html/haddock \
    rm -rf /root/.ghcup/ghc/$GHC_VERSION/share/man \
    rm -rf `find /root/.ghcup/ghc/$GHC_VERSION/share/doc/ghc-$GHC_VERSION -type f -name "*.pdf"` && \
    rm -rf `find /root/.ghcup/ghc/$GHC_VERSION/share/doc/ghc-$GHC_VERSION/html/libraries/ -type d -name src` && \
    rm -rf `find /root/.ghcup/ghc/$GHC_VERSION/share/doc/ghc-$GHC_VERSION/html/libraries/ -type f ! -name "*.haddock"  ! -name "LICENSE" ! -executable` && \
    rm -rf `find /root/.ghcup/ghc/$GHC_VERSION/lib/ghc-$GHC_VERSION/ -type f -name "*.p_hi"` && \
    rm -rf `find /root/.ghcup/ghc/$GHC_VERSION/lib/ghc-$GHC_VERSION/ -type f -name "*.p_o" -o -name "*_p.a"` && \
    rm -rf /root/.ghcup/cache/*.tar.xz && \
    rm -rf /root/.cabal

RUN mkdir -p /root/.local/bin

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PATH=/root/.cabal/bin:/root/.local/bin:/root/.ghcup/bin:$PATH

