<?php
    require("/var/www/unscramblephp/Unscramble.php");

    $appID = $_GET["appID"];
    $groupID = $_GET["groupID"];

    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);

    db_del("fl_apps_groups", "groupID='$groupID' && appID='$appID'", __FILE__, __LINE__);
    db_del("fl_apps_perms_values", "userID='$userID' && appID='$appID'", __FILE__, __LINE__);
?>