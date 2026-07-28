#!/usr/bin/env bash
set -eu

CONTAINER_ID="$(
  docker ps \
    --filter 'label=devcontainer.local_folder=/home/kyoshi/src/zmk' \
    --format '{{.ID}}' \
    | head -n 1
)"

if [ -z "$CONTAINER_ID" ]; then
  echo "ZMK Dev Container is not running." >&2
  exit 1
fi

docker exec -it "$CONTAINER_ID" bash -lc '
cd /workspaces/zmk

west build \
  -p always \
  -s app \
  -d build \
  -b xiao_ble \
  -- \
  -DZMK_CONFIG=/workspaces/zmk-config/config \
  -DZMK_EXTRA_MODULES=/workspaces/zmk-config \
  -DSHIELD=rightb
'
