#!/bin/sh
set -e

if [ "$DEBUG" = "true" ]; then echo "→ [adminer] Setting up configuration"; fi


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

if [ "$DEBUG" = "true" ]; then echo "→ [adminer] Done."; fi
