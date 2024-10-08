FROM snowdreamtech/php:8.1.29

LABEL maintainer="snowdream <sn0wdr1am@qq.com>"

ENV ADMINER_VERSION=4.8.1 \
    ADMINER_PORT=8080 \
    ADMINER_SQLITE_PASSWORD='' \
    ADMINER_PATH=/usr/share/webapps/adminer \
    ADMINER_PLUGINS_PATH=/usr/share/webapps/adminer/plugins \
    ADMINER_DRIVERS_PATH=/usr/share/webapps/adminer/plugins/drivers

RUN mkdir -p ${ADMINER_PATH} \
    && mkdir -p ${ADMINER_PLUGINS_PATH} \
    && mkdir -p ${ADMINER_DRIVERS_PATH} \
    && wget https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php -O ${ADMINER_PATH}/adminer.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/plugin.php -O ${ADMINER_PLUGINS_PATH}/plugin.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/database-hide.php -O ${ADMINER_PLUGINS_PATH}/database-hide.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/designs.php -O ${ADMINER_PLUGINS_PATH}/designs.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/dump-alter.php -O ${ADMINER_PLUGINS_PATH}/dump-alter.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/dump-bz2.php -O ${ADMINER_PLUGINS_PATH}/dump-bz2.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/dump-date.php -O ${ADMINER_PLUGINS_PATH}/dump-date.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/dump-json.php -O ${ADMINER_PLUGINS_PATH}/dump-json.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/dump-xml.php -O ${ADMINER_PLUGINS_PATH}/dump-xml.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/dump-zip.php -O ${ADMINER_PLUGINS_PATH}/dump-zip.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/edit-calendar.php -O ${ADMINER_PLUGINS_PATH}/edit-calendar.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/edit-foreign.php -O ${ADMINER_PLUGINS_PATH}/edit-foreign.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/edit-textarea.php -O ${ADMINER_PLUGINS_PATH}/edit-textarea.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/enum-option.php -O ${ADMINER_PLUGINS_PATH}/enum-option.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/enum-types.php -O ${ADMINER_PLUGINS_PATH}/enum-types.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/file-upload.php -O ${ADMINER_PLUGINS_PATH}/file-upload.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/foreign-system.php -O ${ADMINER_PLUGINS_PATH}/foreign-system.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/frames.php -O ${ADMINER_PLUGINS_PATH}/frames.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/json-column.php -O ${ADMINER_PLUGINS_PATH}/json-column.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/login-otp.php -O ${ADMINER_PLUGINS_PATH}/login-otp.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/login-servers.php -O ${ADMINER_PLUGINS_PATH}/login-servers.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/login-password-less.php -O ${ADMINER_PLUGINS_PATH}/login-password-less.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/login-ssl.php -O ${ADMINER_PLUGINS_PATH}/login-ssl.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/login-table.php -O ${ADMINER_PLUGINS_PATH}/login-table.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/master-slave.php -O ${ADMINER_PLUGINS_PATH}/master-slave.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/pretty-json-column.php -O ${ADMINER_PLUGINS_PATH}/pretty-json-column.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/slugify.php -O ${ADMINER_PLUGINS_PATH}/slugify.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/sql-log.php -O ${ADMINER_PLUGINS_PATH}/sql-log.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/struct-comments.php -O ${ADMINER_PLUGINS_PATH}/struct-comments.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/tables-filter.php -O ${ADMINER_PLUGINS_PATH}/tables-filter.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/tinymce.php -O ${ADMINER_PLUGINS_PATH}/tinymce.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/translation.php -O ${ADMINER_PLUGINS_PATH}/translation.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/version-noverify.php -O ${ADMINER_PLUGINS_PATH}/version-noverify.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/wymeditor.php -O ${ADMINER_PLUGINS_PATH}/wymeditor.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/drivers/clickhouse.php -O ${ADMINER_DRIVERS_PATH}/clickhouse.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/drivers/firebird.php -O ${ADMINER_DRIVERS_PATH}/firebird.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/vrana/adminer/master/plugins/drivers/simpledb.php -O ${ADMINER_DRIVERS_PATH}/simpledb.php 
    


EXPOSE 80

COPY designs /usr/share/webapps/adminer/designs

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["sh","-c","php -S 0.0.0.0:${ADMINER_PORT} -t /usr/share/webapps/adminer"]