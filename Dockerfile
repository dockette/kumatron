FROM debian:trixie-slim AS litestream

ARG TARGETARCH
ENV LITESTREAM_VERSION=v0.3.14

RUN apt update && \
    apt install -y curl && \
    TARGETARCH=$([ "$TARGETARCH" = "aarch64" ] && echo "arm64" || echo "$TARGETARCH"); \
    curl -f -L https://github.com/benbjohnson/litestream/releases/download/${LITESTREAM_VERSION}/litestream-${LITESTREAM_VERSION}-linux-${TARGETARCH}.tar.gz -o /litestream.tar.gz ; \
    mkdir -p /litestream && \
    tar -xzf /litestream.tar.gz -C /litestream

FROM debian:trixie-slim AS envsubst

ARG TARGETARCH
ENV ENVSUBST_VERSION=v1.4.3

RUN apt update && \
    apt install -y curl && \
    TARGETARCH=$(case "$TARGETARCH" in arm64|aarch64) echo "arm64" ;; *) echo "x86_64" ;; esac); \
    curl -f -L https://github.com/a8m/envsubst/releases/download/${ENVSUBST_VERSION}/envsubst-Linux-${TARGETARCH} -o /envsubst && \
    chmod +x /envsubst

FROM louislam/uptime-kuma:1.23.17-debian

ENV DATA_DIR=./data/

COPY --from=litestream /litestream/litestream /usr/local/bin/litestream
COPY --from=envsubst /envsubst /usr/local/bin/envsubst

COPY ./litestream /srv/litestream

RUN mkdir -p /app/data

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
CMD ["/entrypoint.sh"]
