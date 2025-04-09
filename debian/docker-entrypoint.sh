#!/bin/sh
set -e

# Random ADMINER_SQLITE_PASSWORD Generator
if [ -z "${ADMINER_SQLITE_PASSWORD}" ]; then
    {
        ADMINER_SQLITE_PASSWORD=$(openssl rand -base64 33)
        echo "ADMINER_SQLITE_PASSWORD = ${ADMINER_SQLITE_PASSWORD}"
    }
fi

# adminer-plugins.php
cat >"${ADMINER_PATH}"/adminer-plugins.php <<EOF
<?php // adminer-plugins.php

    // designs autoloader
    \$designs = array();
	foreach (glob("designs/*", GLOB_ONLYDIR) as \$filename) {
        \$designs["\$filename/adminer.css"] = basename(\$filename);
    }
    
    
return array(
    // You can specify all plugins here or just the ones needing configuration.
    # new AdminerDatabaseHide(array('information_schema' , 'mysql' , 'performance_schema' , 'sys')),
    new AdminerDatabaseHide(array()),
    new AdminerLoginPasswordLess(password_hash("${ADMINER_SQLITE_PASSWORD}", PASSWORD_DEFAULT)),
    new AdminerDesigns(\$designs),
    );
?>
EOF
    
# index.php
cat >"${ADMINER_PATH}"/index.php <<EOF
<?php
// include original Adminer or Adminer Editor
include "./adminer.php";
?>
EOF





# start nginx
/usr/sbin/nginx -c /etc/nginx/nginx.conf

#fpm
/usr/bin/php-fpm --fpm-config /etc/php/8.2/fpm/php-fpm.conf

# exec commands
if [ -n "$*" ]; then
    sh -c "$*"
fi

# keep the docker container running
# https://github.com/docker/compose/issues/1926#issuecomment-422351028
if [ "${KEEPALIVE}" -eq 1 ]; then
    trap : TERM INT
    tail -f /dev/null &
    wait
    # sleep infinity & wait
fi
