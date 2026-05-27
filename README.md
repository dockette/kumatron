<h1 align=center>Dockette / Kumatron</h1>

<p align=center>
   <a href="https://github.com/dockette/kumatron/actions"><img src="https://github.com/dockette/kumatron/actions/workflows/docker.yml/badge.svg" alt="GitHub Actions"></a>
   <a href="https://hub.docker.com/r/dockette/kumatron"><img src="https://img.shields.io/docker/pulls/dockette/kumatron.svg" alt="Docker Hub pulls"></a>
   <a href="https://github.com/sponsors/f3l1x"><img src="https://img.shields.io/badge/sponsor-GitHub%20Sponsors-ea4aaa" alt="GitHub Sponsors"></a>
   <a href="https://github.com/orgs/dockette/discussions"><img src="https://img.shields.io/badge/support-discussions-6f42c1" alt="Support/Discussions"></a>
</p>

<p align=center>
   🐳 <a href="https://github.com/louislam/uptime-kuma">Uptime Kuma</a> with extra juicy configuration and streaming SQLite.
</p>

<p align=center>
🕹 <a href="https://f3l1x.io">f3l1x.io</a> | 💻 <a href="https://github.com/f3l1x">f3l1x</a> | 🐦 <a href="https://twitter.com/xf3l1x">@xf3l1x</a>
</p>

-----

## Usage

**Basic**

```
docker run \
	-it \
	--rm \
	-p 3001:3001 \
	-e DATA_DIR=./data \
	-v /your/path:/app/data \
	dockette/kumatron
```

## SQLite + Litestream

> [Litestream](https://litestream.io/) is extra horse power for SQLite. Stream SQLite to cloud storage, e.q. S3.

```
docker run \
	-it \
	--rm \
	-p 3001:3001 \
	-e DATA_DIR=./data \
	-e LITESTREAM=1 \
	-e LITESTREAM_TEMPLATE=s3 \
	-e LITESTREAM_DB_FILE=/app/data/kuma.db \
	-e LITESTREAM_S3_ENDPOINT=yourbucket.minio.tld \
	-e LITESTREAM_S3_REGION=foobar \
	-e LITESTREAM_S3_PATH=foobar \
	-e LITESTREAM_S3_BUCKET=foobar \
	-e LITESTREAM_S3_ACCESS_KEY_ID=foobar \
	-e LITESTREAM_S3_SECRET_ACCESS_KEY=foobarbaz \
	-e LITESTREAM_RETENTION=24h \
	-e LITESTREAM_RETENTION_CHECK_INTERVAL=1h \
	-e LITESTREAM_SNAPSHOT_INTERVAL=10s \
	-e LITESTREAM_SYNC_INTERVAL=1s \
	-e LITESTREAM_VALIDATION_INTERVAL=12h \
	-v /your/path:/app/data \
	dockette/kumatron
```

> [!TIP]
> For more detailed configuration options, please refer to the [Litestream official documentation](https://litestream.io/reference/config/).

## Development

```sh
make build
make test
make run
```

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
