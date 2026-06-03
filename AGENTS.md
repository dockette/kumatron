# AGENTS.md

## Project

Dockette image for Uptime Kuma with optional Litestream support for streaming SQLite backups to remote storage such as S3.

## Image

- Docker image: `dockette/kumatron`.
- Build context is the repository root and `Dockerfile` is the only image definition.
- Runtime base is `louislam/uptime-kuma:1.23.16-debian`.
- Builder stages download Litestream `v0.3.13` and `envsubst`, then copy them into the runtime image.
- Runtime data defaults to `DATA_DIR=./data/`; `/app/data` is created by the image.
- GitHub Actions publishes `latest` and `20250502` from the root context.

## Commands

- `make build` builds `dockette/kumatron:${DOCKER_TAG}`.
- `make test` starts `kumatron-test` and probes the app with Node over `DOCKER_TEST_PORT`.
- `make run` starts the image on `${DOCKER_TEST_PORT}:3001` as container `kumatron`.
- `make enter` opens a shell in the running `kumatron` container.
- `make test-s3` runs with Litestream S3 environment variables from `.env.dist` and optional `.env`.

## Testing

- Use `make -n build test run` to dry-run the default commands before changing build logic.
- A real `make test` needs Docker and a built local image; it removes `kumatron-test` on success or failure.
- Litestream S3 testing needs valid `.env` values and should not commit secrets.

## Guidelines

- Keep `Dockerfile`, `entrypoint.sh`, `litestream/`, `Makefile`, README examples, and `.github/workflows/docker.yml` aligned.
- Prefer `DOCKER_*` names for Docker-related Makefile variables.
- Place `.PHONY: <target>` directly above each Makefile target.
- Preserve Litestream environment variable names because README examples and templates depend on them.
- Do not introduce unrelated formatting or structural changes.
