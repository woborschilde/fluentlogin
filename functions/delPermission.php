<?php
    require("/var/www/unscramblephp/Unscramble.php");

    $appID = $_GET["appID"];
    $permissionID = $_GET["permissionID"];

    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);

    db_del("fl_apps_permissions", "permID='$permissionID'", __FILE__, __LINE__);
    
    // deprecated:
    //$conn->query("ALTER TABLE fl_apps_groups DROP perm$appID" . "_$permissionID");
?>