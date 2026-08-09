#!/usr/bin/env bash
set -euo pipefail

docker compose run --rm \
    --user "$(id -u):$(id -g)" \
    zmk \
    west build \
        "$@" \
        -s app \
        -d build \
        -b xiao_ble/nrf52840/zmk \
        -S studio-rpc-usb-uart \
        -- \
        -DZMK_CONFIG=/workspaces/zmk-config/config \
        -DZMK_EXTRA_MODULES=/workspaces/zmk-config \
        -DSHIELD=rightb
