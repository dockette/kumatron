# Include variables
include .env.dist
-include .env
export

DOCKER_IMAGE=dockette/kumatron
DOCKER_TAG?=latest
DOCKER_TEST_PORT?=3001

.PHONY: build enter test test-s3 run

build:
	docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .

enter:
	docker exec -it kumatron bash

test:
	docker rm -f kumatron-test >/dev/null 2>&1 || true
	docker run -d --name kumatron-test ${DOCKER_IMAGE}:${DOCKER_TAG}
	for i in $$(seq 1 60); do \
		if docker exec kumatron-test node -e "require('http').get('http://127.0.0.1:${DOCKER_TEST_PORT}', (res) => process.exit(res.statusCode >= 200 && res.statusCode < 500 ? 0 : 1)).on('error', () => process.exit(1))"; then \
			docker rm -f kumatron-test >/dev/null; \
			exit 0; \
		fi; \
		sleep 2; \
	done; \
	docker logs kumatron-test; \
	docker rm -f kumatron-test >/dev/null; \
	exit 1

run:
	docker run \
		-it \
		--rm \
		-p ${DOCKER_TEST_PORT}:3001 \
		--name kumatron \
		${DOCKER_IMAGE}:${DOCKER_TAG}

test-s3:
	docker run \
		-it \
		--rm \
		-p ${DOCKER_TEST_PORT}:3001 \
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
		${DOCKER_IMAGE}:${DOCKER_TAG}
