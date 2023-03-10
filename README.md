<h1 align=center>Dockette / Kumatron</h1>

<p align=center>
   🐳 [Uptime Kuma](https://github.com/louislam/uptime-kuma) with extra juicy configuration and streaming SQLite.
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
	dockette/kumatron
```

## Development

See [how to contribute](https://contributte.org/contributing.html) to this package.

This package is currently maintaining by these authors.

<a href="https://github.com/f3l1x">
    <img width="80" height="80" src="https://avatars2.githubusercontent.com/u/538058?v=3&s=80">
</a>

-----

Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Also thank you for using this package.
