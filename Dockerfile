FROM alpine
RUN apk update
# g++, git, ld, make, etc.
RUN apk add --no-cache alpine-sdk
# git setting
RUN git config --global pull.rebase false
# Haskell
RUN apk add ghc
RUN apk add curl
RUN apk add musl-dev
RUN apk add zlib-dev
RUN curl -sSL https://get.haskellstack.org/ | sh
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

