<?php
    require("/var/www/unscramblephp/Unscramble.php");

    $permissionID = $_GET["permissionID"];

    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);

	db_san($_GET);

	// Check admin login status
	require("checkLogin.php");
	
    db_del("fl_apps_permissions", "permID='$permissionID'", __FILE__, __LINE__);
    db_del("fl_apps_perms_values", "permID='$permissionID'", __FILE__, __LINE__);
?>