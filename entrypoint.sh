#!/bin/bash
set -Eeo pipefail

echo "Kumatron"

printf "\n\n"

echo "UPTIME KUMA ======================"
echo "DATA_DIR=${DATA_DIR}"

printf "\n\n"

echo "LITESTREAM ======================="
if [[ ! -z "${LITESTREAM}" ]]; then
    echo "LITESTREAM_TEMPLATE=${LITESTREAM_TEMPLATE}"
    echo "LITESTREAM_DB_FILE=${LITESTREAM_DB_FILE}"
    echo "LITESTREAM_S3_ENDPOINT=${LITESTREAM_S3_ENDPOINT}"
    echo "LITESTREAM_S3_REGION=${LITESTREAM_S3_REGION}"
    echo "LITESTREAM_S3_BUCKET=${LITESTREAM_S3_BUCKET}"
    echo "LITESTREAM_S3_PATH=${LITESTREAM_S3_PATH}"
    echo "LITESTREAM_S3_ACCESS_KEY_ID=${LITESTREAM_S3_ACCESS_KEY_ID}"
    echo "LITESTREAM_S3_SECRET_ACCESS_KEY=${LITESTREAM_S3_SECRET_ACCESS_KEY}"

    if [[ ! -z "${LITESTREAM_TEMPLATE}" ]]; then
        echo "Using template: /srv/litestream/${LITESTREAM_TEMPLATE}.yml.tpl"
        envsubst < /srv/litestream/${LITESTREAM_TEMPLATE}.yml.tpl > /srv/litestream/litestream.yml
        echo "Litestream config: /srv/litestream/litestream.yml"
        cat /srv/litestream/litestream.yml
    fi
else
    echo "Not used"
fi


printf "\n\n"

if [[ ! -z "${LITESTREAM}" ]]; then
    litestream restore -v -if-replica-exists -config /srv/litestream/litestream.yml "${LITESTREAM_DB_FILE}"
    exec litestream replicate -config /srv/litestream/litestream.yml -exec "node /app/server/server.js"
else
    exec node /app/server/server.js
fi
