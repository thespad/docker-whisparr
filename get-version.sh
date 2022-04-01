#! /bin/bash

APP_VERSION=$(curl -sL "https://whisparr.servarr.com/v1/update/nightly/changes?runtime=netcore&os=linuxmusl" | jq -r '.[0].version');

printf "%s" "${APP_VERSION}"