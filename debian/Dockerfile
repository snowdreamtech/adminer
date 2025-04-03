FROM snowdreamtech/php:8.2.26-fpm-bookworm

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Adminer Image Based On Debian" \
    org.opencontainers.image.description="Docker Images for Adminer on Debian. (i386,amd64,arm32v5,arm32v7,arm64,mips64le,ppc64le,s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/adminer" \
    org.opencontainers.image.base.name="snowdreamtech/adminer:debian" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/adminer" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="5.1.1" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/adminer"
    
# Switch to the user
USER root

# Set the workdir
WORKDIR /root

# keep the docker container running
ENV KEEPALIVE=1 \
    # The cap_net_bind_service capability in Linux allows a process to bind a socket to Internet domain privileged ports, 
    # which are port numbers less than 1024. 
    CAP_NET_BIND_SERVICE=0

ENV ADMINER_VERSION=5.1.1 \
    ADMINER_SQLITE_PASSWORD='' \
    ADMINER_PATH=/usr/share/nginx/html \
    ADMINER_THEMES_PATH=/usr/share/nginx/html/designs \
    ADMINER_PLUGINS_PATH=/usr/share/nginx/html/plugins \
    ADMINER_DRIVERS_PATH=/usr/share/nginx/html/plugins/drivers \
    GITHUB_PROXY=

ARG GID=1000 \
    UID=1000  \
    USER=root \
    WORKDIR=/root

# Create a user with UID and GID
RUN set -eux \
    && if [ "${USER}" != "root" ]; then \
    addgroup --gid ${GID} ${USER}; \
    adduser --home /home/${USER} --uid ${UID} --gid ${GID} --gecos ${USER} --shell /bin/bash --disabled-password ${USER}; \
    # sed -i "/%sudo/c ${USER} ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers; \
    fi \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy --purge autoremove \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* 

# Enable CAP_NET_BIND_SERVICE
RUN set -eux \
    && if [ "${USER}" != "root" ] && [ "${CAP_NET_BIND_SERVICE}" -eq 1 ]; then \
    DEBIAN_FRONTEND=noninteractive apt-get -qqy update; \
    DEBIAN_FRONTEND=noninteractive apt-get -qqy install --no-install-recommends libcap2-bin; \
    # setcap 'cap_net_bind_service=+ep' `which nginx`; \
    fi \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy --purge autoremove \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* 

COPY designs ${ADMINER_THEMES_PATH}

RUN mkdir -p ${ADMINER_PATH} \
    && mkdir -p ${ADMINER_THEMES_PATH} \
    && mkdir -p ${ADMINER_PLUGINS_PATH} \
    && mkdir -p ${ADMINER_DRIVERS_PATH} \
    && wget https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php -O ${ADMINER_PATH}/adminer.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/plugin.php -O ${ADMINER_PLUGINS_PATH}/plugin.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/database-hide.php -O ${ADMINER_PLUGINS_PATH}/database-hide.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/designs.php -O ${ADMINER_PLUGINS_PATH}/designs.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/dump-alter.php -O ${ADMINER_PLUGINS_PATH}/dump-alter.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/dump-bz2.php -O ${ADMINER_PLUGINS_PATH}/dump-bz2.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/dump-date.php -O ${ADMINER_PLUGINS_PATH}/dump-date.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/dump-json.php -O ${ADMINER_PLUGINS_PATH}/dump-json.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/dump-xml.php -O ${ADMINER_PLUGINS_PATH}/dump-xml.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/dump-zip.php -O ${ADMINER_PLUGINS_PATH}/dump-zip.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/edit-calendar.php -O ${ADMINER_PLUGINS_PATH}/edit-calendar.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/edit-foreign.php -O ${ADMINER_PLUGINS_PATH}/edit-foreign.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/edit-textarea.php -O ${ADMINER_PLUGINS_PATH}/edit-textarea.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/enum-option.php -O ${ADMINER_PLUGINS_PATH}/enum-option.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/file-upload.php -O ${ADMINER_PLUGINS_PATH}/file-upload.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/foreign-system.php -O ${ADMINER_PLUGINS_PATH}/foreign-system.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/frames.php -O ${ADMINER_PLUGINS_PATH}/frames.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/json-column.php -O ${ADMINER_PLUGINS_PATH}/json-column.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/login-otp.php -O ${ADMINER_PLUGINS_PATH}/login-otp.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/login-servers.php -O ${ADMINER_PLUGINS_PATH}/login-servers.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/login-password-less.php -O ${ADMINER_PLUGINS_PATH}/login-password-less.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/login-ssl.php -O ${ADMINER_PLUGINS_PATH}/login-ssl.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/login-table.php -O ${ADMINER_PLUGINS_PATH}/login-table.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/master-slave.php -O ${ADMINER_PLUGINS_PATH}/master-slave.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/pretty-json-column.php -O ${ADMINER_PLUGINS_PATH}/pretty-json-column.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/slugify.php -O ${ADMINER_PLUGINS_PATH}/slugify.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/sql-log.php -O ${ADMINER_PLUGINS_PATH}/sql-log.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/tables-filter.php -O ${ADMINER_PLUGINS_PATH}/tables-filter.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/tinymce.php -O ${ADMINER_PLUGINS_PATH}/tinymce.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/translation.php -O ${ADMINER_PLUGINS_PATH}/translation.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/version-noverify.php -O ${ADMINER_PLUGINS_PATH}/version-noverify.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/wymeditor.php -O ${ADMINER_PLUGINS_PATH}/wymeditor.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/drivers/clickhouse.php -O ${ADMINER_DRIVERS_PATH}/clickhouse.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/drivers/firebird.php -O ${ADMINER_DRIVERS_PATH}/firebird.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/drivers/simpledb.php -O ${ADMINER_DRIVERS_PATH}/simpledb.php \
    && chown -Rv nginx:nginx ${ADMINER_PATH} 

# Switch to the user
USER nginx

# Set the workdir
WORKDIR ${ADMINER_PATH}

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]