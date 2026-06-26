#!/bin/sh

# adminer-plugins.php
if [ "$DEBUG" = "true" ]; then
    rm -rfv "${ADMINER_PLUGINS_PATH}"/login-servers.php

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
    # new AdminerLoginServers(array(
    #     'localhost' => 'localhost',
    #     '127.0.0.1' => '127.0.0.1',
    #     'db' => 'db',
    #     'mysql' => 'mysql',
    #     'mariadb' => 'mariadb',
    #     'sqlite' => 'sqlite',
    #     'postgres' => 'postgres',
    #     'pg' => 'pg',
    # ))
);
EOF
    echo "ADMINER_SQLITE_PASSWORD = ${ADMINER_SQLITE_PASSWORD}"
fi
