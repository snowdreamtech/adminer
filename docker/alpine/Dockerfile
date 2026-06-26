# Base Image (Alpine Variant)
# Extends snowdreamtech/php with additional tooling and configuration.

FROM snowdreamtech/php:8.4.22-nginx-alpine

# Build-time Configuration
ARG BUILDTIME \
    VERSION \
    REVISION \
    KEEPALIVE=0 \
    CAP_NET_BIND_SERVICE=0 \
    LANG=C.UTF-8 \
    UMASK=022 \
    DEBUG=false \
    PASSWORDLESS_SUDO=false \
    PGID=0 \
    PUID=0 \
    USER=root \
    WORKDIR=/root \
    ADMINER_SQLITE_PASSWORD="" \
    ADMINER_PATH=/var/www/html \
    ADMINER_PLUGINS_PATH=/var/www/html/plugins \
    ADMINER_DESIGNS_PATH=/var/www/html/designs

# x-release-please-start-version
ARG ADMINER_VERSION=5.4.2
# x-release-please-end

# Standard OCI Metadata (https://github.com/opencontainers/image-spec)
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Adminer Image Based On Alpine" \
    org.opencontainers.image.description="Docker Images for Adminer on Alpine. (i386, amd64, arm32v6, arm32v7, arm64, ppc64le, riscv64, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/adminer" \
    org.opencontainers.image.base.name="snowdreamtech/php:8.4.22-nginx-alpine" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/adminer" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.created="${BUILDTIME}" \
    org.opencontainers.image.revision="${REVISION}" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/adminer"

# x-release-please-start-version
LABEL org.opencontainers.image.version="${VERSION:-5.4.2}"
# x-release-please-end

# Runtime Environment Configuration
ENV KEEPALIVE=${KEEPALIVE} \
    CAP_NET_BIND_SERVICE=${CAP_NET_BIND_SERVICE} \
    LANG=${LANG} \
    UMASK=${UMASK} \
    DEBUG=${DEBUG} \
    PASSWORDLESS_SUDO=${PASSWORDLESS_SUDO} \
    PGID=${PGID} \
    PUID=${PUID} \
    USER=${USER} \
    WORKDIR=${WORKDIR} \
    ADMINER_VERSION=${ADMINER_VERSION} \
    ADMINER_SQLITE_PASSWORD=${ADMINER_SQLITE_PASSWORD} \
    ADMINER_PATH=${ADMINER_PATH} \
    ADMINER_PLUGINS_PATH=${ADMINER_PLUGINS_PATH} \
    ADMINER_DESIGNS_PATH=${ADMINER_DESIGNS_PATH}

# Additional tooling and configuration for Adminer
RUN apk update \
    && apk add --no-cache \
    vim curl tar \
    && mkdir -p ${ADMINER_PATH} \
    && curl -fsSL "https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php" -o ${ADMINER_PATH}/adminer.php \
    && curl -fsSL "https://github.com/vrana/adminer/archive/refs/tags/v${ADMINER_VERSION}.tar.gz" -o adminer-src.tar.gz \
    && tar -xzf adminer-src.tar.gz "adminer-${ADMINER_VERSION}/plugins" "adminer-${ADMINER_VERSION}/designs" \
    && cp -r "adminer-${ADMINER_VERSION}/plugins" ${ADMINER_PATH}/ \
    && cp -r "adminer-${ADMINER_VERSION}/designs" ${ADMINER_PATH}/ \
    && rm -rf "adminer-${ADMINER_VERSION}" adminer-src.tar.gz

# Container Orchestration Files
COPY entrypoint.d /usr/local/bin/entrypoint.d

RUN chmod +x /usr/local/bin/entrypoint.d/*

# Standard Healthcheck (Verification of core system responsiveness)
HEALTHCHECK NONE

# Process Execution
EXPOSE 80 443
USER root
WORKDIR /root
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/bin/sh"]
