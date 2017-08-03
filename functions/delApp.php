<?php
    require("/var/www/unscramblephp/Unscramble.php");

    $appID = $_GET["appID"];

    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);

    db_del("fl_apps", "appID='$appID'", __FILE__, __LINE__);
?>