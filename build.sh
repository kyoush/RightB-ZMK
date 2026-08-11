#!/usr/bin/env bash
set -euo pipefail

docker compose run --rm \
    --user "$(id -u):$(id -g)" \
    zmk \
    west build \
        "$@" \
        -s zmk/app \
        -d /workspaces/zmk-config/build \
        -b xiao_ble/nrf52840/zmk \
        -S studio-rpc-usb-uart \
        -- \
        -DZephyr_DIR=/workspaces/zmk/zephyr/share/zephyr-package/cmake \
        -DZMK_CONFIG=/workspaces/zmk-config/config \
        -DZMK_EXTRA_MODULES="/workspaces/zmk-config;/workspaces/zmk/modules/zmk-rgbled-widget" \
        -DSHIELD="rightb rgbled_adapter"
