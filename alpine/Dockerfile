FROM snowdreamtech/php:8.4.5-fpm-alpine3.21

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Adminer Image Based On Alpine" \
    org.opencontainers.image.description="Docker Images for Adminer on Alpine. (i386, amd64, arm32v6, arm32v7, arm64, ppc64le,riscv64, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/adminer" \
    org.opencontainers.image.base.name="snowdreamtech/adminer:alpine" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/adminer" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="5.2.0" \
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

ENV ADMINER_VERSION=5.2.0 \
    ADMINER_SQLITE_PASSWORD='' \
    ADMINER_PATH=/var/lib/nginx/html \
    ADMINER_THEMES_PATH=/var/lib/nginx/html/designs \
    ADMINER_PLUGINS_PATH=/var/lib/nginx/html/adminer-plugins \
    ADMINER_DRIVERS_PATH=/var/lib/nginx/html/adminer-plugins \
    GITHUB_PROXY=

ARG GID=1000 \
    UID=1000  \
    USER=root \
    WORKDIR=/root

# Create a user with UID and GID
RUN if [ "${USER}" != "root" ]; then \
    addgroup -g ${GID} ${USER}; \
    adduser -h /home/${USER} -u ${UID} -g ${USER} -G ${USER} -s /bin/sh -D ${USER}; \
    # sed -i "/%sudo/c ${USER} ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers; \
    fi

# Enable CAP_NET_BIND_SERVICE
RUN if [ "${USER}" != "root" ] && [ "${CAP_NET_BIND_SERVICE}" -eq 1 ]; then \
    apk add --no-cache libcap; \
    # setcap 'cap_net_bind_service=+ep' `which nginx`; \
    fi

COPY designs ${ADMINER_THEMES_PATH}

RUN mkdir -p ${ADMINER_PATH} \
    && mkdir -p ${ADMINER_THEMES_PATH} \
    && mkdir -p ${ADMINER_PLUGINS_PATH} \
    && mkdir -p ${ADMINER_DRIVERS_PATH} \
    && wget https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php -O ${ADMINER_PATH}/adminer.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/adminer.js.php -O ${ADMINER_PLUGINS_PATH}/adminer.js.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/backward-keys.php -O ${ADMINER_PLUGINS_PATH}/backward-keys.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/before-unload.php -O ${ADMINER_PLUGINS_PATH}/before-unload.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/config.php -O ${ADMINER_PLUGINS_PATH}/config.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/dark-switcher.php -O ${ADMINER_PLUGINS_PATH}/dark-switcher.php \
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
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/editor-setup.php -O ${ADMINER_PLUGINS_PATH}/editor-setup.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/editor-views.php -O ${ADMINER_PLUGINS_PATH}/editor-views.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/enum-option.php -O ${ADMINER_PLUGINS_PATH}/enum-option.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/file-upload.php -O ${ADMINER_PLUGINS_PATH}/file-upload.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/foreign-system.php -O ${ADMINER_PLUGINS_PATH}/foreign-system.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/frames.php -O ${ADMINER_PLUGINS_PATH}/frames.php \
    # && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/codemirror.php -O ${ADMINER_PLUGINS_PATH}/codemirror.php \
    # && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/monaco.php -O ${ADMINER_PLUGINS_PATH}/monaco.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/prism.php -O ${ADMINER_PLUGINS_PATH}/prism.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/json-column.php -O ${ADMINER_PLUGINS_PATH}/json-column.php \
    # && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/login-otp.php -O ${ADMINER_PLUGINS_PATH}/login-otp.php \
    # && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/login-servers.php -O ${ADMINER_PLUGINS_PATH}/login-servers.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/login-password-less.php -O ${ADMINER_PLUGINS_PATH}/login-password-less.php \
    # && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/login-ssl.php -O ${ADMINER_PLUGINS_PATH}/login-ssl.php \
    # && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/login-table.php -O ${ADMINER_PLUGINS_PATH}/login-table.php \
    # && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/master-slave.php -O ${ADMINER_PLUGINS_PATH}/master-slave.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/menu-links.php -O ${ADMINER_PLUGINS_PATH}/menu-links.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/pretty-json-column.php -O ${ADMINER_PLUGINS_PATH}/pretty-json-column.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/select-email.php -O ${ADMINER_PLUGINS_PATH}/select-email.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/slugify.php -O ${ADMINER_PLUGINS_PATH}/slugify.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/sql-gemini.php -O ${ADMINER_PLUGINS_PATH}/sql-gemini.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/sql-log.php -O ${ADMINER_PLUGINS_PATH}/sql-log.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/table-indexes-structure.php -O ${ADMINER_PLUGINS_PATH}/table-indexes-structure.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/table-structure.php -O ${ADMINER_PLUGINS_PATH}/table-structure.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/tables-filter.php -O ${ADMINER_PLUGINS_PATH}/tables-filter.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/tinymce.php -O ${ADMINER_PLUGINS_PATH}/tinymce.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/translation.php -O ${ADMINER_PLUGINS_PATH}/translation.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/version-noverify.php -O ${ADMINER_PLUGINS_PATH}/version-noverify.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/drivers/clickhouse.php -O ${ADMINER_DRIVERS_PATH}/clickhouse.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/drivers/firebird.php -O ${ADMINER_DRIVERS_PATH}/firebird.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/drivers/simpledb.php -O ${ADMINER_DRIVERS_PATH}/simpledb.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/drivers/elastic.php -O ${ADMINER_DRIVERS_PATH}/elastic.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/drivers/imap.php -O ${ADMINER_DRIVERS_PATH}/imap.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/refs/tags/v${ADMINER_VERSION}/plugins/drivers/mongo.php -O ${ADMINER_DRIVERS_PATH}/mongo.php \
    && chown -Rv nginx:nginx ${ADMINER_PATH} 

# Switch to the user
USER nginx

# Set the workdir
WORKDIR ${ADMINER_PATH}

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]