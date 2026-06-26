#!/bin/sh
set -e

if [ "$DEBUG" = "true" ]; then echo "→ Setting up Adminer plugins"; fi

# Ensure we have index.php to load plugins properly
cat >"${ADMINER_PATH}"/index.php <<'PHP'
<?php
function adminer_object() {
    // Fix for AdminerDesigns plugin not persisting theme on login page in Adminer 5.x
    if (session_status() === PHP_SESSION_NONE) {
        session_name("adminer_sid");
        $params = array(
            0,
            preg_replace('~\?.*~', '', $_SERVER["REQUEST_URI"]),
            "",
            isset($_SERVER["HTTPS"]) && strcasecmp($_SERVER["HTTPS"], "off"),
            true
        );
        session_set_cookie_params($params[0], $params[1], $params[2], $params[3], $params[4]);
        session_start();
    }
    if (isset($_POST["design"])) {
        $_SESSION["design"] = $_POST["design"];
    }

    $plugins = array();
    
    // 1. AdminerDesigns
    include_once __DIR__ . "/plugins/designs.php";
    $designs = array();
    foreach (glob(__DIR__ . "/designs/*", GLOB_ONLYDIR) as $filename) {
        $designs["designs/" . basename($filename) . "/adminer.css"] = basename($filename);
    }
    $plugins[] = new AdminerDesigns($designs);
    
    // 2. AdminerDatabaseHide
    include_once __DIR__ . "/plugins/database-hide.php";
    $plugins[] = new AdminerDatabaseHide(array());
    
    // 3. AdminerLoginPasswordLess
    $sqlite_pass = getenv("ADMINER_SQLITE_PASSWORD");
    if ($sqlite_pass) {
        include_once __DIR__ . "/plugins/login-password-less.php";
        $plugins[] = new AdminerLoginPasswordLess(password_hash($sqlite_pass, PASSWORD_DEFAULT));
    }
    
    // 4. AdminerLoginServers (controlled by env var)
    $server_mode = getenv("ADMINER_DEFAULT_SERVER_MODE");
    if ($server_mode !== "false" && $server_mode !== "0") {
        include_once __DIR__ . "/plugins/login-servers.php";
        $plugins[] = new AdminerLoginServers(array(
            'MySQL (db)' => array('server' => 'db', 'driver' => 'server'),
            'MySQL (mysql)' => array('server' => 'mysql', 'driver' => 'server'),
            'MySQL (mariadb)' => array('server' => 'mariadb', 'driver' => 'server'),
            'PostgreSQL (db)' => array('server' => 'db', 'driver' => 'pgsql'),
            'PostgreSQL (postgres)' => array('server' => 'postgres', 'driver' => 'pgsql'),
            'SQLite' => array('server' => '', 'driver' => 'sqlite'),
            'Elasticsearch' => array('server' => 'elasticsearch', 'driver' => 'elastic'),
            'Elasticsearch (es)' => array('server' => 'es', 'driver' => 'elastic'),
            'ClickHouse' => array('server' => 'clickhouse', 'driver' => 'clickhouse'),
            'SimpleDB' => array('server' => 'simpledb', 'driver' => 'simpledb'),
            'IGDB' => array('server' => 'igdb', 'driver' => 'igdb'),
        ));
    }
    
    // 5. Driver Plugins
    include_once __DIR__ . "/plugins/drivers/clickhouse.php";
    include_once __DIR__ . "/plugins/drivers/elastic.php";
    include_once __DIR__ . "/plugins/drivers/simpledb.php";
    include_once __DIR__ . "/plugins/drivers/igdb.php";
    
    
    return new \Adminer\Plugins($plugins);
}

// include original adminer.php
include __DIR__ . "/adminer.php";
PHP

if [ "$DEBUG" = "true" ]; then
    echo "ADMINER_SQLITE_PASSWORD = ${ADMINER_SQLITE_PASSWORD}"
fi
