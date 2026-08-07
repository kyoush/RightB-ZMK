#!/usr/bin/env bash
set -eu

WORKSPACE="$HOME/src/zmk"

CONTAINER_ID="$(
  devcontainer up \
    --workspace-folder "$WORKSPACE" \
    --log-format json \
    2>/dev/null \
  | jq -r 'select(.containerId) | .containerId'
)"

if [ -z "$CONTAINER_ID" ]; then
  echo "ZMK Dev Container is not running." >&2
  exit 1
fi

docker exec -it "$CONTAINER_ID" bash -lc '
cd /workspaces/zmk

# Enable USB logging (CDC ACM) for development.
west build \
  -s app \
  -d build \
  -b xiao_ble/nrf52840/zmk \
  -S zmk-usb-logging \
  -- \
  -DZMK_CONFIG=/workspaces/zmk-config/config \
  -DZMK_EXTRA_MODULES=/workspaces/zmk-config \
  -DSHIELD=rightb \
  -DCONFIG_ZMK_STUDIO=y
'
