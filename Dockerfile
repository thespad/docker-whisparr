FROM ghcr.io/linuxserver/baseimage-alpine:3.15

# set version label
ARG BUILD_DATE
ARG VERSION
ARG APP_VERSION
LABEL build_version="Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thespad"

# environment settings
ARG APP_BRANCH="nightly"
ENV XDG_CONFIG_HOME="/config/xdg"

RUN \
  echo "**** install packages ****" && \
  apk add -U --upgrade --no-cache \
    curl \
    jq \
    icu-libs \
    sqlite-libs && \
  echo "**** install whisparr ****" && \
  mkdir -p /app/whisparr/bin && \
  if [ -z ${APP_VERSION+x} ]; then \
    APP_VERSION=$(curl -sL "https://whisparr.servarr.com/v1/update/${APP_BRANCH}/changes?runtime=netcore&os=linuxmusl" \
    | jq -r '.[0].version'); \
  fi && \
  curl -o \
    /tmp/whisparr.tar.gz -L \
    "https://whisparr.servarr.com/v1/update/${APP_BRANCH}/updatefile?version=${APP_VERSION}&os=linuxmusl&runtime=netcore&arch=x64" && \
  tar xzf \
  /tmp/whisparr.tar.gz -C \
    /app/whisparr/bin --strip-components=1 && \
  echo -e "UpdateMethod=docker\nBranch=${APP_BRANCH}\nPackageVersion=${VERSION}\nPackageAuthor=[thespad](https://github.com/thespad)" > /app/whisparr/package_info && \
  echo "**** cleanup ****" && \
  rm -rf \
    /app/whisparr/bin/Whisparr.Update \
    /tmp/* \
    /var/tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 6969
VOLUME /config
