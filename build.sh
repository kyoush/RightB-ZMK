#!/usr/bin/env bash
set -euo pipefail

docker compose run --rm \
    --user "$(id -u):$(id -g)" \
    zmk \
    west build \
        "$@" \
        -s app \
        -d /workspaces/zmk-config/build \
        -b xiao_ble/nrf52840/zmk \
        -S studio-rpc-usb-uart \
        -- \
        -DZMK_CONFIG=/workspaces/zmk-config/config \
        -DZMK_EXTRA_MODULES="/workspaces/zmk-config;/workspaces/zmk-config/.zmk/modules/zmk-rgbled-widget" \
        -DSHIELD="rightb rgbled_adapter"
