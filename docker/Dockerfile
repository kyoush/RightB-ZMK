FROM zmkfirmware/zmk-dev-arm:stable

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/* \
    && curl -LsSf https://astral.sh/uv/install.sh | sh

RUN /root/.local/bin/uv tool install zmk==0.4.1 \
    && ln -s /root/.local/bin/zmk /usr/local/bin/zmk
