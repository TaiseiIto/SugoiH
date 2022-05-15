FROM alpine
RUN apk update
# g++, git, ld, make, etc.
RUN apk add --no-cache alpine-sdk
# git setting
RUN git config --global pull.rebase false
# ssh
RUN apk add --no-cache openssh
COPY ssh /~/ssh
# editor
RUN apk add --no-cache vim
# set time zone UTC+9 (Japan)
RUN apk add --no-cache tzdata
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN apk del tzdata
# clone the repository
WORKDIR ~
RUN git clone https://github.com/TaiseiIto/SugoiH.git
WORKDIR SugoiH

