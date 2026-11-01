# Docker Image Tags Reference

This document describes the Docker image tagging strategy for the Adminer project.

## Tag Naming Convention

All images use the format: `snowdreamtech/adminer:TAG`

Where `TAG` follows these patterns:

- **Variant-specific tags**: `TAG-variant` (e.g., `nightly-alpine`, `6.2.0-alpine`)
- **Default tags** (Debian only): `TAG` (e.g., `nightly`, `latest`, `6.2.0`)

## Supported Registries

All tags are pushed to two registries:

- **GitHub Container Registry**: `ghcr.io/snowdreamtech/adminer:TAG`
- **DockerHub**: `snowdreamtech/adminer:TAG`

## Tag Scenarios

### 1. Branch Builds (dev/main)

#### Push to `dev` branch

```bash
git push origin dev
```

**Generated tags:**

```
snowdreamtech/adminer:dev-alpine
snowdreamtech/adminer:dev-debian
snowdreamtech/adminer:dev              # ← Debian (default)
snowdreamtech/adminer:dev-rocky
```

#### Push to `main` branch

```bash
git push origin main
```

**Generated tags:**

```
snowdreamtech/adminer:main-alpine
snowdreamtech/adminer:latest-alpine
snowdreamtech/adminer:main-debian
snowdreamtech/adminer:latest-debian
snowdreamtech/adminer:main             # ← Debian (default)
snowdreamtech/adminer:latest           # ← Debian (default)
snowdreamtech/adminer:main-rocky
snowdreamtech/adminer:latest-rocky
```

### 2. Scheduled Nightly Builds

Runs daily at 17:00 UTC.

**Generated tags:**

```
# Current date (e.g., 20260408)
snowdreamtech/adminer:20260408-alpine
snowdreamtech/adminer:20260408-debian
snowdreamtech/adminer:20260408         # ← Debian (default)
snowdreamtech/adminer:20260408-rocky

# Nightly moving tag
snowdreamtech/adminer:nightly-alpine
snowdreamtech/adminer:nightly-debian
snowdreamtech/adminer:nightly          # ← Debian (default)
snowdreamtech/adminer:nightly-rocky
```

### 3. Release Please Tag Builds

When Release Please creates a release tag:

- Format: `variant-vx.y.z` (e.g., `alpine-v6.2.0`, `debian-v6.2.0`, `rocky-v6.2.0`)

**Generated tags:**

```
# For tag: alpine-v6.2.0
snowdreamtech/adminer:6.2.0-alpine
snowdreamtech/adminer:latest-alpine

# For tag: debian-v6.2.0 (default variant)
snowdreamtech/adminer:6.2.0-debian
snowdreamtech/adminer:latest-debian
snowdreamtech/adminer:6.2.0            # ← Debian (default)
snowdreamtech/adminer:latest           # ← Debian (default)

# For tag: rocky-v6.2.0
snowdreamtech/adminer:6.2.0-rocky
snowdreamtech/adminer:latest-rocky
```

## Summary Table

| Event | Variant | Generated Tags |
|-------|---------|----------------|
| Push `dev` | Alpine | `dev-alpine` |
| Push `dev` | Debian | `dev-debian`, `dev` |
| Push `dev` | Rocky | `dev-rocky` |
| Push `main` | Alpine | `main-alpine`, `latest-alpine` |
| Push `main` | Debian | `main-debian`, `latest-debian`, `main`, `latest` |
| Push `main` | Rocky | `main-rocky`, `latest-rocky` |
| Nightly | Alpine | `YYYYMMDD-alpine`, `nightly-alpine` |
| Nightly | Debian | `YYYYMMDD-debian`, `nightly-debian`, `YYYYMMDD`, `nightly` |
| Nightly | Rocky | `YYYYMMDD-rocky`, `nightly-rocky` |
| Tag `alpine-v6.2.0` | Alpine | `6.2.0-alpine`, `latest-alpine` |
| Tag `debian-v6.2.0` | Debian | `6.2.0-debian`, `latest-debian`, `6.2.0`, `latest` |
| Tag `rocky-v6.2.0` | Rocky | `6.2.0-rocky`, `latest-rocky` |
