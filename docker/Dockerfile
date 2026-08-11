FROM zmkfirmware/zmk-dev-arm:stable

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/* \
    && curl -LsSf https://astral.sh/uv/install.sh | sh

RUN UV_TOOL_DIR=/opt/uv/tools UV_TOOL_BIN_DIR=/usr/local/bin /root/.local/bin/uv tool install zmk==0.4.1
RUN mkdir -p /workspaces/zmk && chown 1000:1000 /workspaces/zmk
