# Adminer

![Docker Image Version](https://img.shields.io/docker/v/snowdreamtech/adminer)
![Docker Image Size](https://img.shields.io/docker/image-size/snowdreamtech/adminer/latest)
![Docker Pulls](https://img.shields.io/docker/pulls/snowdreamtech/adminer)
![Docker Stars](https://img.shields.io/docker/stars/snowdreamtech/adminer)

Docker images for [Adminer](https://www.adminer.org/) (formerly phpMinAdmin), a full-featured database management tool written in PHP. Supports MySQL, MariaDB, PostgreSQL, SQLite, MS SQL, Oracle, Elasticsearch, MongoDB, and more — all in a single PHP file.

## Overview

This project provides production-ready Adminer Docker images based on `snowdreamtech/php` with Nginx, available in three distribution variants:

- **Alpine** — Lightweight, minimal image size
- **Debian** — Default, widely-compatible
- **Rocky** — Enterprise-focused, RHEL-compatible

## Quick Start

```bash
# Pull and run the default Debian variant
docker pull snowdreamtech/adminer:debian
docker run -d --name=adminer -p 8080:80 snowdreamtech/adminer:debian

# Access Adminer at http://localhost:8080/adminer.php
```

## Distribution Variants

### Debian (Default)

The recommended variant for most use cases, providing wide compatibility and extensive package availability.

```bash
docker run -d \
  --name=adminer \
  -p 8080:80 \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/adminer:debian
```

**Supported Architectures**: i386, amd64, arm32v5, arm32v7, arm64, riscv64, ppc64le, s390x

**Base Image**: `snowdreamtech/php:8.4.16-nginx-debian`

### Alpine

Lightweight variant optimized for minimal image size and fast startup times.

```bash
docker run -d \
  --name=adminer \
  -p 8080:80 \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/adminer:alpine
```

**Supported Architectures**: i386, amd64, arm32v6, arm32v7, arm64, ppc64le, riscv64, s390x

**Base Image**: `snowdreamtech/php:8.4.22-nginx-alpine`

### Rocky

Enterprise-focused variant based on Rocky Linux, ideal for production environments requiring RHEL compatibility.

```bash
docker run -d \
  --name=adminer \
  -p 8080:80 \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/adminer:rocky
```

**Supported Architectures**: amd64, arm64, ppc64le, s390x

**Base Image**: `snowdreamtech/php:8.4.21-nginx-rocky`

## Build Instructions

### Single Architecture Build

```bash
# Build Debian variant
docker build -t snowdreamtech/adminer:debian ./docker/debian/

# Build Alpine variant
docker build -t snowdreamtech/adminer:alpine ./docker/alpine/

# Build Rocky variant
docker build -t snowdreamtech/adminer:rocky ./docker/rocky/
```

### Multi-Architecture Build

Build images for multiple architectures using `docker buildx`:

```bash
# Create and use a buildx builder
docker buildx create --use --name build --node build --driver-opt network=host

# Build Debian for multiple architectures
docker buildx build \
  --platform=linux/386,linux/amd64,linux/arm/v5,linux/arm/v7,linux/arm64,linux/riscv64,linux/ppc64le,linux/s390x \
  -t snowdreamtech/adminer:debian \
  ./docker/debian/ \
  --push

# Build Alpine for multiple architectures
docker buildx build \
  --platform=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x \
  -t snowdreamtech/adminer:alpine \
  ./docker/alpine/ \
  --push

# Build Rocky for multiple architectures
docker buildx build \
  --platform=linux/amd64,linux/arm64,linux/ppc64le,linux/s390x \
  -t snowdreamtech/adminer:rocky \
  ./docker/rocky/ \
  --push
```

## Environment Variables

All variants support the following environment variables for runtime configuration:

| Variable | Default | Description |
|----------|---------|-------------|
| `KEEPALIVE` | `0` | Keep container running (1=enabled, 0=disabled) |
| `CAP_NET_BIND_SERVICE` | `0` | Enable binding to privileged ports (<1024) |
| `LANG` | `C.UTF-8` | Locale setting for UTF-8 character support |
| `UMASK` | `022` | Default file creation mask |
| `DEBUG` | `false` | Enable debug output in entrypoint scripts |
| `PGID` | `0` | Primary group ID for custom user creation |
| `PUID` | `0` | User ID for custom user creation |
| `USER` | `root` | Username for custom user creation |
| `WORKDIR` | `/root` | Working directory path |
| `TZ` | - | Timezone (e.g., `Asia/Shanghai`, `America/New_York`) |
| `ADMINER_VERSION` | `5.4.2` | Adminer version |
| `ADMINER_SQLITE_PASSWORD` | `` | SQLite password for passwordless login plugin |
| `ADMINER_PATH` | `/var/www/html` | Path to Adminer web root |
| `ADMINER_PLUGINS_PATH` | `/var/www/html/plugins` | Path to Adminer plugins |
| `ADMINER_DESIGNS_PATH` | `/var/www/html/designs` | Path to Adminer designs/themes |

**Debian-specific**:

| Variable | Default | Description |
|----------|---------|-------------|
| `DEBIAN_FRONTEND` | `noninteractive` | Debian package installation mode |

## Docker Compose Examples

### Simple Configuration

```yaml
services:
  adminer:
    image: snowdreamtech/adminer:debian
    container_name: adminer
    ports:
      - "8080:80"
    environment:
      - TZ=Asia/Shanghai
    restart: unless-stopped
```

### Advanced Configuration with Database

```yaml
services:
  adminer:
    image: snowdreamtech/adminer:debian
    container_name: adminer
    ports:
      - "8080:80"
    environment:
      - TZ=Asia/Shanghai
      - DEBUG=true
    restart: unless-stopped

  mysql:
    image: mysql:8
    container_name: mysql
    environment:
      - MYSQL_ROOT_PASSWORD=secret
    volumes:
      - mysql_data:/var/lib/mysql
    restart: unless-stopped

volumes:
  mysql_data:
```

## Semantic Versioning Tags

Images follow semantic versioning with the format: `{major}.{minor}.{patch}-{variant}`

Examples:

- `snowdreamtech/adminer:5.4.2-debian`
- `snowdreamtech/adminer:5.4.2-alpine`
- `snowdreamtech/adminer:5.4.2-rocky`

This format allows:

- **Full version pinning**: `5.4.2-debian` (exact version)
- **Variant latest tag**: `latest-debian` (tracks most recent release for Debian)
- **Global latest tag**: `latest` (tracks most recent release, defaults to Debian)

## Architecture Support

Each distribution variant supports multiple CPU architectures for deployment across diverse hardware platforms:

| Variant | Architectures |
|---------|---------------|
| **Debian** | i386, amd64, arm32v5, arm32v7, arm64, riscv64, ppc64le, s390x |
| **Alpine** | i386, amd64, arm32v6, arm32v7, arm64, ppc64le, riscv64, s390x |
| **Rocky** | amd64, arm64, ppc64le, s390x |

Docker automatically selects the appropriate architecture for your platform when pulling images.

## Entrypoint System

The image includes a flexible entrypoint system that executes custom initialization scripts before starting your application.

### How It Works

1. The `docker-entrypoint.sh` script runs at container startup
2. It executes all executable scripts in `/usr/local/bin/entrypoint.d/` in lexical order
3. Each script receives the container's command-line arguments
4. If any script fails, the container stops (fail-fast behavior)

### Debug Mode

Enable debug output to troubleshoot entrypoint execution:

```bash
docker run -e DEBUG=true snowdreamtech/adminer:debian
```

## Reference

1. [Adminer Official Website](https://www.adminer.org/)
2. [Adminer GitHub Repository](https://github.com/vrana/adminer)
3. [使用 buildx 构建多平台 Docker 镜像](https://icloudnative.io/posts/multiarch-docker-with-buildx/)
4. [如何使用 docker buildx 构建跨平台 Go 镜像](https://waynerv.com/posts/building-multi-architecture-images-with-docker-buildx/#buildx-%E7%9A%84%E8%B7%A8%E5%B9%B3%E5%8F%B0%E6%9E%84%E5%BB%BA%E7%AD%96%E7%95%A5)
5. [Building Multi-Arch Images for Arm and x86 with Docker Desktop](https://www.docker.com/blog/multi-arch-images/)
6. [How to Rapidly Build Multi-Architecture Images with Buildx](https://www.docker.com/blog/how-to-rapidly-build-multi-architecture-images-with-buildx/)
7. [docker/buildx](https://github.com/docker/buildx)

## Contact (备注：adminer)

* Email: <sn0wdr1am@qq.com>
* QQ: 3217680847
* QQ群: 949022145
* WeChat/微信群: sn0wdr1am

## License

MIT
