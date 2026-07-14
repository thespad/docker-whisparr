# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine:3.24

# set version label
ARG BUILD_DATE
ARG VERSION
ARG APP_VERSION
LABEL build_version="Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thespad"
LABEL org.opencontainers.image.source="https://github.com/thespad/docker-whisparr"
LABEL org.opencontainers.image.url="https://github.com/thespad/docker-whisparr"
LABEL org.opencontainers.image.description="An adult movie collection manager for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new movies and will interface with clients and indexers to grab, sort, and rename them."
LABEL org.opencontainers.image.authors="thespad"

# environment settings
ARG APP_BRANCH="eros"
ENV XDG_CONFIG_HOME="/config/xdg"

RUN \
  echo "**** install packages ****" && \
  apk add -U --upgrade --no-cache \
    icu-libs \
    sqlite-libs \
    xmlstarlet && \
  echo "**** install whisparr ****" && \
  mkdir -p /app/whisparr/bin && \
  if [ -z ${APP_VERSION+x} ]; then \
    APP_VERSION=$(curl -s https://api.github.com/repos/Whisparr/Whisparr-Eros/releases/latest \
    | awk '/tag_name/{print $4;exit}' FS='[""]'); \
  fi && \
  curl -Lo \
    /tmp/whisparr.tar.gz \
    "https://github.com/Whisparr/Whisparr-Eros/releases/download/${APP_VERSION}/Whisparr.eros.${APP_VERSION#v}.linux-musl-x64.tar.gz" && \
  tar xzf \
  /tmp/whisparr.tar.gz -C \
    /app/whisparr/bin --strip-components=1 && \
  echo -e "UpdateMethod=docker\nBranch=${APP_BRANCH}\nPackageVersion=${VERSION}\nPackageAuthor=[thespad](https://github.com/thespad)" > /app/whisparr/package_info && \
  printf "Version: ${VERSION}\nBuild-date: ${BUILD_DATE}" > /build_version && \
  echo "**** cleanup ****" && \
  rm -rf \
    /app/whisparr/bin/Whisparr.Update \
    /tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 6969

VOLUME /config
