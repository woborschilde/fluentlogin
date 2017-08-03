<?php
    require("/var/www/unscramblephp/Unscramble.php");

    $fieldID = $_GET["fieldID"];

    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);

    db_del("fl_apps_fields", "fieldID='$fieldID'", __FILE__, __LINE__);
?>