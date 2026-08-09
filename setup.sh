#!/usr/bin/env bash
set -euo pipefail

USER_UID="$(id -u)"
USER_GID="$(id -g)"

if ! docker compose run --rm zmk test -d /workspaces/zmk/.west; then
    echo "==> Creating ZMK workspace..."

    docker compose run --rm \
        --user root \
        zmk \
        sh -c '
set -e

cd /workspaces

git clone https://github.com/zmkfirmware/zmk zmk

cd zmk
west init -l app/
west update
'
fi

docker compose run --rm \
    --user root \
    zmk \
    chown -R "${USER_UID}:${USER_GID}" /workspaces/zmk

docker compose run --rm \
    --user "${USER_UID}:${USER_GID}" \
    zmk \
    sh -c '
set -e

cd /workspaces/zmk

echo "==> Updating workspace..."
west update
'
