# Include variables
include .env.dist
-include .env
export

build:
	docker build -t dockette/kumatron .

enter:
	docker exec -it kumatron bash

test:
	docker run \
		-it \
		--rm \
		-p 3001:3001 \
		--name kumatron \
		dockette/kumatron

test-s3:
	docker run \
		-it \
		--rm \
		-p 3001:3001 \
		-e LITESTREAM=1 \
		-e LITESTREAM_TEMPLATE=${LITESTREAM_TEMPLATE} \
		-e LITESTREAM_DB_FILE=${LITESTREAM_DB_FILE} \
		-e LITESTREAM_S3_ENDPOINT=${LITESTREAM_S3_ENDPOINT} \
		-e LITESTREAM_S3_REGION=${LITESTREAM_S3_REGION} \
		-e LITESTREAM_S3_BUCKET=${LITESTREAM_S3_BUCKET} \
		-e LITESTREAM_S3_PATH=${LITESTREAM_S3_PATH} \
		-e LITESTREAM_S3_ACCESS_KEY_ID=${LITESTREAM_S3_ACCESS_KEY_ID} \
		-e LITESTREAM_S3_SECRET_ACCESS_KEY=${LITESTREAM_S3_SECRET_ACCESS_KEY} \
		--name kumatron \
		dockette/kumatron
