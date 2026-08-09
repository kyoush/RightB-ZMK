#!/usr/bin/env bash
set -euo pipefail

USER_UID="$(id -u)"
USER_GID="$(id -g)"

docker compose run --rm \
    --user "${USER_UID}:${USER_GID}" \
    zmk \
    sh -c '
set -e

cd /workspaces/zmk-config

zmk config user.home /workspaces/zmk-config
zmk update
'
