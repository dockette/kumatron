dbs:
  - path: "${LITESTREAM_DB_FILE}"
    replicas:
      - type: s3
        bucket: "${LITESTREAM_S3_BUCKET}"
        path: "${LITESTREAM_S3_PATH}"
        endpoint: "${LITESTREAM_S3_ENDPOINT}"
        region: "${LITESTREAM_S3_REGION}"
        access-key-id: "${LITESTREAM_S3_ACCESS_KEY_ID}"
        secret-access-key: "${LITESTREAM_S3_SECRET_ACCESS_KEY}"
