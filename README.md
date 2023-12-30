# [thespad/whisparr](https://github.com/thespad/docker-whisparr)

[![GitHub Release](https://img.shields.io/github/release/thespad/docker-whisparr.svg?color=26689A&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github&include_prereleases)](https://github.com/thespad/docker-whisparr/releases)
![Commits](https://img.shields.io/github/commits-since/thespad/docker-whisparr/latest?color=26689A&include_prereleases&logo=github&style=for-the-badge)
![Image Size](https://img.shields.io/docker/image-size/thespad/whisparr/latest?color=26689A&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=Size)
[![Docker Pulls](https://img.shields.io/docker/pulls/thespad/whisparr.svg?color=26689A&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=pulls&logo=docker)](https://hub.docker.com/r/thespad/whisparr)
[![GitHub Stars](https://img.shields.io/github/stars/thespad/docker-whisparr.svg?color=26689A&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/thespad/docker-whisparr)
[![Docker Stars](https://img.shields.io/docker/stars/thespad/whisparr.svg?color=26689A&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=stars&logo=docker)](https://hub.docker.com/r/thespad/whisparr)

[![ci](https://img.shields.io/github/actions/workflow/status/thespad/docker-whisparr/call-check-and-release.yml?branch=nightly&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github&label=Check%20For%20Upstream%20Updates)](https://github.com/thespad/docker-whisparr/actions/workflows/call-check-and-release.yml)
[![ci](https://img.shields.io/github/actions/workflow/status/thespad/docker-whisparr/call-baseimage-update.yml?branch=nightly&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github&label=Check%20For%20Baseimage%20Updates)](https://github.com/thespad/docker-whisparr/actions/workflows/call-baseimage-update.yml)
[![ci](https://img.shields.io/github/actions/workflow/status/thespad/docker-whisparr/call-build-image.yml?labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github&label=Build%20Image)](https://github.com/thespad/docker-whisparr/actions/workflows/call-build-image.yml)

[whisparr](https://github.com/whisparr/whisparr) is an adult movie collection manager for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new movies and will interface with clients and indexers to grab, sort, and rename them. It can also be configured to automatically upgrade the quality of existing files in the library when a better quality format becomes available.

## Supported Architectures

Our images support multiple architectures and simply pulling `ghcr.io/thespad/whisparr:latest` should retrieve the correct image for your arch.

The architectures supported by this image are:

| Architecture | Available | Tag |
| :----: | :----: | ---- |
| x86-64 | ✅ | latest |
| arm64 | ✅ | latest |

## Application Setup

Webui is accessible at `http://SERVERIP:PORT`

## Usage

Here are some example snippets to help you get started creating a container.

### docker-compose ([recommended](https://docs.linuxserver.io/general/docker-compose))

Compatible with docker-compose v2 schemas.

```yaml
---
version: "2.1"
services:
  get_iplayer:
    image: ghcr.io/thespad/whisparr:latest
    container_name: whisparr
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/New_York
    volumes:
      - </path/to/appdata/config>:/config
      - </path/to/appdata/downloads>:/downloads
    ports:
      - 6969:6969
    restart: unless-stopped
```

### docker cli

```shell
docker run -d \
  --name=whisparr \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=America/New_York \
  -p 6969:6969 \
  -v </path/to/appdata/config>:/config \
  -v </path/to/appdata/downloads>:/downloads \
  --restart unless-stopped \
  ghcr.io/thespad/whisparr:latest
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 6969` | Web GUI |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=America/New_York` | Specify a timezone to use EG America/New_York |
| `-v /config` | Contains all relevant configuration files. |
| `-v /downloads` | Storage location for all get_iplayer download files. |

### Image Update Notifications - Diun (Docker Image Update Notifier)

* We recommend [Diun](https://crazymax.dev/diun/) for update notifications. Other tools that automatically update containers unattended are not recommended or supported.

## Versions

* **30.12.23:** - Rebase to Alpine 3.19.
* **14.05.23:** - Rebase to Alpine 3.18. Drop support for armhf.
* **09.12.22:** - Rebase to 3.17.
* **23.09.22:** - Rebase to 3.16, migrate to s6v3.
* **01.04.22:** - Initial Release.
