<?php
    require("/var/www/unscramblephp/Unscramble.php");

    $groupID = $_GET["groupID"];

    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);

	db_san($_GET);

	// Check admin login status
	require("checkLogin.php");
	
    db_del("fl_apps_groups", "groupID='$groupID'", __FILE__, __LINE__);
    db_del("fl_apps_perms_values", "groupID='$groupID'", __FILE__, __LINE__);
?>