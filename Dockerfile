FROM debian:bullseye-slim AS litestream

ARG TARGETARCH
ENV LITESTREAM_VERSION=v0.5.12

RUN apt update && \
    apt install -y curl && \
    case "${TARGETARCH}" in \
        amd64) LITESTREAM_ARCH=x86_64 ;; \
        arm64|aarch64) LITESTREAM_ARCH=arm64 ;; \
        *) LITESTREAM_ARCH="${TARGETARCH}" ;; \
    esac && \
    curl -f -L https://github.com/benbjohnson/litestream/releases/download/${LITESTREAM_VERSION}/litestream-${LITESTREAM_VERSION#v}-linux-${LITESTREAM_ARCH}.tar.gz -o /litestream.tar.gz && \
    mkdir -p /litestream && \
    tar -xzf /litestream.tar.gz -C /litestream

FROM debian:bullseye-slim AS envsubst

ARG TARGETARCH
ENV ENVSUBST_VERSION=v1.4.2

RUN apt update && \
    apt install -y curl && \
    TARGETARCH=$([ "$TARGETARCH" = "aarch64" ] && echo "arm64" || echo "x86_64"); \
    curl -f -L https://github.com/a8m/envsubst/releases/download/v1.2.0/envsubst-Linux-${TARGETARCH} -o /envsubst && \
    chmod +x /envsubst

FROM louislam/uptime-kuma:2.4.0

ENV DATA_DIR=./data/

COPY --from=litestream /litestream/litestream /usr/local/bin/litestream
COPY --from=envsubst /envsubst /usr/local/bin/envsubst

COPY ./litestream /srv/litestream

RUN mkdir -p /app/data

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
CMD ["/entrypoint.sh"]
