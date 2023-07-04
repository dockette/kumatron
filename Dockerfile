FROM debian:bullseye-slim as litestream

ARG TARGETARCH
ENV LITESTREAM_VERSION=v0.3.9

RUN apt update && \
    apt install -y curl && \
    TARGETARCH=$([ "$TARGETARCH" = "aarch64" ] && echo "arm64" || echo "$TARGETARCH"); \
    curl -f -L https://github.com/benbjohnson/litestream/releases/download/${LITESTREAM_VERSION}/litestream-${LITESTREAM_VERSION}-linux-${TARGETARCH}-static.tar.gz -o /litestream.tar.gz ; \
    mkdir -p /litestream && \
    tar -xzf /litestream.tar.gz -C /litestream

FROM debian:bullseye-slim as envsubst

ARG TARGETARCH
ENV ENVSUBST_VERSION=v1.4.2

RUN apt update && \
    apt install -y curl && \
    TARGETARCH=$([ "$TARGETARCH" = "aarch64" ] && echo "arm64" || echo "x86_64"); \
    curl -f -L https://github.com/a8m/envsubst/releases/download/v1.2.0/envsubst-Linux-${TARGETARCH} -o /envsubst && \
    chmod +x /envsubst

FROM louislam/uptime-kuma:1.22.1

ENV DATA_DIR=./data/

COPY --from=litestream /litestream/litestream /usr/local/bin/litestream
COPY --from=envsubst /envsubst /usr/local/bin/envsubst

COPY ./litestream /srv/litestream

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
CMD ["/entrypoint.sh"]
