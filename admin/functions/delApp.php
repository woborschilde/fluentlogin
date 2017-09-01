<?php
    require("../../lib/unsphp/Unscramble.php");

    $appID = $_GET["appID"];

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

	// Check admin login status
	require("checkLogin.php");
	
    db_del("fl_apps", "appID='$appID'", __FILE__, __LINE__);
    db_del("fl_appsettings_values", "appID='$appID'", __FILE__, __LINE__);
    db_del("fl_apps_fields", "appID='$appID'", __FILE__, __LINE__);
    db_del("fl_apps_fields_values", "appID='$appID'", __FILE__, __LINE__);
    db_del("fl_apps_groups", "appID='$appID'", __FILE__, __LINE__);
    db_del("fl_apps_permissions", "appID='$appID'", __FILE__, __LINE__);
    db_del("fl_apps_perms_values", "appID='$appID'", __FILE__, __LINE__);
    db_del("fl_apps_sessions", "appID='$appID'", __FILE__, __LINE__);
    db_del("fl_apps_users", "appID='$appID'", __FILE__, __LINE__);
    db_del("fl_apps_user_to_groups", "appID='$appID'", __FILE__, __LINE__);
?>