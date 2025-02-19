FROM snowdreamtech/php:8.4.2-fpm-alpine3.21

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Adminer Image Based On Alpine" \
    org.opencontainers.image.description="Docker Images for Adminer on Alpine. (i386, amd64, arm32v6, arm32v7, arm64, ppc64le,riscv64, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/adminer" \
    org.opencontainers.image.base.name="snowdreamtech/adminer:alpine" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/adminer" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="3.21.0" \
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

ENV ADMINER_VERSION=4.8.1 \
    ADMINER_SQLITE_PASSWORD='' \
    ADMINER_PATH=/var/lib/nginx/html \
    ADMINER_THEMES_PATH=/var/lib/nginx/html/designs \
    ADMINER_PLUGINS_PATH=/var/lib/nginx/html/plugins \
    ADMINER_DRIVERS_PATH=/var/lib/nginx/html/plugins/drivers \
    GITHUB_PROXY=https://gh-proxy.sn0wdr1am.com/

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
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/plugin.php -O ${ADMINER_PLUGINS_PATH}/plugin.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/database-hide.php -O ${ADMINER_PLUGINS_PATH}/database-hide.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/designs.php -O ${ADMINER_PLUGINS_PATH}/designs.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/dump-alter.php -O ${ADMINER_PLUGINS_PATH}/dump-alter.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/dump-bz2.php -O ${ADMINER_PLUGINS_PATH}/dump-bz2.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/dump-date.php -O ${ADMINER_PLUGINS_PATH}/dump-date.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/dump-json.php -O ${ADMINER_PLUGINS_PATH}/dump-json.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/dump-xml.php -O ${ADMINER_PLUGINS_PATH}/dump-xml.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/dump-zip.php -O ${ADMINER_PLUGINS_PATH}/dump-zip.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/edit-calendar.php -O ${ADMINER_PLUGINS_PATH}/edit-calendar.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/edit-foreign.php -O ${ADMINER_PLUGINS_PATH}/edit-foreign.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/edit-textarea.php -O ${ADMINER_PLUGINS_PATH}/edit-textarea.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/enum-option.php -O ${ADMINER_PLUGINS_PATH}/enum-option.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/enum-types.php -O ${ADMINER_PLUGINS_PATH}/enum-types.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/file-upload.php -O ${ADMINER_PLUGINS_PATH}/file-upload.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/foreign-system.php -O ${ADMINER_PLUGINS_PATH}/foreign-system.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/frames.php -O ${ADMINER_PLUGINS_PATH}/frames.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/json-column.php -O ${ADMINER_PLUGINS_PATH}/json-column.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/login-otp.php -O ${ADMINER_PLUGINS_PATH}/login-otp.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/login-servers.php -O ${ADMINER_PLUGINS_PATH}/login-servers.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/login-password-less.php -O ${ADMINER_PLUGINS_PATH}/login-password-less.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/login-ssl.php -O ${ADMINER_PLUGINS_PATH}/login-ssl.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/login-table.php -O ${ADMINER_PLUGINS_PATH}/login-table.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/master-slave.php -O ${ADMINER_PLUGINS_PATH}/master-slave.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/pretty-json-column.php -O ${ADMINER_PLUGINS_PATH}/pretty-json-column.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/slugify.php -O ${ADMINER_PLUGINS_PATH}/slugify.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/sql-log.php -O ${ADMINER_PLUGINS_PATH}/sql-log.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/struct-comments.php -O ${ADMINER_PLUGINS_PATH}/struct-comments.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/tables-filter.php -O ${ADMINER_PLUGINS_PATH}/tables-filter.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/tinymce.php -O ${ADMINER_PLUGINS_PATH}/tinymce.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/translation.php -O ${ADMINER_PLUGINS_PATH}/translation.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/version-noverify.php -O ${ADMINER_PLUGINS_PATH}/version-noverify.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/wymeditor.php -O ${ADMINER_PLUGINS_PATH}/wymeditor.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/drivers/clickhouse.php -O ${ADMINER_DRIVERS_PATH}/clickhouse.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/drivers/firebird.php -O ${ADMINER_DRIVERS_PATH}/firebird.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/vrana/adminer/master/plugins/drivers/simpledb.php -O ${ADMINER_DRIVERS_PATH}/simpledb.php \
    && chown -Rv nginx:nginx ${ADMINER_PATH} 

# Switch to the user
USER nginx

# Set the workdir
WORKDIR ${ADMINER_PATH}

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]