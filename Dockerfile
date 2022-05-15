FROM alpine
RUN apk update
# g++, git, ld, make, etc.
RUN apk add --no-cache alpine-sdk
# git setting
RUN git config --global pull.rebase false
# Haskell
RUN apk add --no-cache autoconf
RUN apk add --no-cache automake
RUN apk add --no-cache binutils-gold
RUN apk add --no-cache build-base
RUN apk add --no-cache coreutils
RUN apk add --no-cache cpio
RUN apk add --no-cache curl
RUN apk add --no-cache ghc
RUN apk add --no-cache linux-headers
RUN apk add --no-cache libffi-dev
RUN apk add --no-cache musl-dev
RUN apk add --no-cache ncurses-dev
RUN apk add --no-cache perl
RUN apk add --no-cache python3
RUN apk add --no-cache py3-sphinx
RUN apk add --no-cache zlib-dev
RUN curl -sSL https://get.haskellstack.org/ | sh
RUN apk add --no-cache cabal
RUN cabal update
RUN cabal install --lib random
# ssh
RUN apk add --no-cache openssh
RUN mkdir /root/.ssh
# editor
RUN apk add --no-cache vim
# set time zone UTC+9 (Japan)
RUN apk add --no-cache tzdata
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN apk del tzdata
# clone the repository
WORKDIR /root
RUN git clone https://github.com/TaiseiIto/SugoiH.git
WORKDIR SugoiH

