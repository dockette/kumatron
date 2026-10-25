<h1 align=center>Dockette / Kumatron</h1>

<p align=center>
   🐳 <a href="https://github.com/louislam/uptime-kuma">Uptime Kuma</a> with extra juicy configuration and streaming SQLite.
</p>

<p align=center>
🕹 <a href="https://f3l1x.io">f3l1x.io</a> | 💻 <a href="https://github.com/f3l1x">f3l1x</a> | 🐦 <a href="https://twitter.com/xf3l1x">@xf3l1x</a>
</p>

-----

[Uptime Kuma](https://github.com/louislam/uptime-kuma) with [Litestream](https://litestream.io/) added. Litestream
streams the SQLite database to cloud storage, e.g. S3.

## Features

- Uptime Kuma `1.23.17` on the upstream `-debian` image
- Litestream `v0.3.14` for streaming SQLite, off by default
- Litestream config is rendered from a template with `envsubst` (`v1.4.3`)

## Usage

```sh
docker run -it --rm -p 3001:3001 -e DATA_DIR=./data -v /your/path:/app/data dockette/kumatron
```

```sh
# Stream SQLite to S3
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

## Configuration

Litestream is on when `LITESTREAM` is set. The entrypoint renders `/srv/litestream/<LITESTREAM_TEMPLATE>.yml.tpl` to
`/srv/litestream/litestream.yml`. The `LITESTREAM_RETENTION*`, `LITESTREAM_SNAPSHOT_INTERVAL`,
`LITESTREAM_SYNC_INTERVAL` and `LITESTREAM_VALIDATION_INTERVAL` values above are the defaults.

For all options, see the [Litestream documentation](https://litestream.io/reference/config/).

## Versions

| Version | Release |
|---------|---------|
| `dockette/kumatron:YYYY.MM.DD` | release `YYYY.MM.DD` |
| `dockette/kumatron:latest` | latest build of `master` |

Releases are listed on [GitHub](https://github.com/dockette/kumatron/releases).

## Development

```sh
make build       # build the image
make test        # run the image on port 3001
make test-s3     # run the image with Litestream, settings from .env
make enter       # open a shell in the running container
make version     # print VERSION
make release     # set today's date in VERSION
```

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to
[support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
