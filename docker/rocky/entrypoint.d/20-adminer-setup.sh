#!/bin/sh
set -e

if [ "$DEBUG" = "true" ]; then echo "→ Setting up Adminer plugins"; fi

# Ensure we have index.php to load plugins properly
cat >"${ADMINER_PATH}"/index.php <<'PHP'
<?php
function adminer_object() {
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
    
    // 4. AdminerLoginServers (commented out by default)
    // include_once __DIR__ . "/plugins/login-servers.php";
    // $plugins[] = new AdminerLoginServers(array(
    //     'localhost' => 'localhost',
    //     '127.0.0.1' => '127.0.0.1',
    //     'db' => 'db',
    //     'mysql' => 'mysql',
    //     'mariadb' => 'mariadb',
    //     'sqlite' => 'sqlite',
    //     'postgres' => 'postgres',
    //     'pg' => 'pg',
    // ));
    
    return new \Adminer\Plugins($plugins);
}

// include original adminer.php
include __DIR__ . "/adminer.php";
PHP

if [ "$DEBUG" = "true" ]; then
    echo "ADMINER_SQLITE_PASSWORD = ${ADMINER_SQLITE_PASSWORD}"
fi
