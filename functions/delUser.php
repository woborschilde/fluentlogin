<?php
    require("/var/www/unscramblephp/Unscramble.php");

    $appID = $_GET["appID"];
    $userID = $_GET["userID"];

    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);

	db_san($_GET);
	
    db_del("fl_apps_users", "userID='$userID' && appID='$appID'", __FILE__, __LINE__);
    db_del("fl_apps_user_to_groups", "userID='$userID' && appID='$appID'", __FILE__, __LINE__);
?>