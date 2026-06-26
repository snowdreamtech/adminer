#!/bin/sh
set -e

if [ "$DEBUG" = "true" ]; then echo "→ Setting up Adminer plugins"; fi

# Ensure we have index.php to load plugins properly
cat >"${ADMINER_PATH}"/index.php <<'PHP'
<?php
function adminer_object() {
    // required to run any plugin
    include_once "./plugins/plugin.php";
    
    // auto-load all plugins
    foreach (glob("plugins/*.php") as $filename) {
        include_once "./$filename";
    }
    
    $plugins = array();
    
    // Auto-instantiate plugins that don't require arguments
    foreach (get_declared_classes() as $class) {
        if (strpos($class, 'Adminer') === 0 && $class !== 'AdminerPlugin') {
            $ref = new ReflectionClass($class);
            if ($ref->isInstantiable()) {
                $constructor = $ref->getConstructor();
                if (!$constructor || $constructor->getNumberOfRequiredParameters() == 0) {
                    // Skip certain plugins if they conflict
                    if ($class === 'AdminerLoginPasswordLess' || $class === 'AdminerDatabaseHide' || $class === 'AdminerDesigns') {
                        continue;
                    }
                    $plugins[] = new $class();
                }
            }
        }
    }
    
    // auto-load designs
    $designs = array();
    foreach (glob("designs/*", GLOB_ONLYDIR) as $filename) {
        $designs["$filename/adminer.css"] = basename($filename);
    }
    $plugins[] = new AdminerDesigns($designs);
    
    // manually load specific plugins requiring configuration
    $plugins[] = new AdminerDatabaseHide(array());
    
    $sqlite_pass = getenv("ADMINER_SQLITE_PASSWORD");
    if ($sqlite_pass) {
        $plugins[] = new AdminerLoginPasswordLess(password_hash($sqlite_pass, PASSWORD_DEFAULT));
    }
    
    return new AdminerPlugin($plugins);
}

// include original adminer.php
include "./adminer.php";
PHP

if [ "$DEBUG" = "true" ]; then
    echo "ADMINER_SQLITE_PASSWORD = ${ADMINER_SQLITE_PASSWORD}"
fi
