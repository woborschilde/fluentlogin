<?php
    require("/var/www/unscramblephp/Unscramble.php");
    
	if ($_GET["adminID"] != "0") {
		$adminID = $_GET["adminID"];
	}

    $adminName = $_GET["adminName"];
    $adminPassword = $_GET["adminPassword"];

    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);

	db_san($_GET);

	// Check admin login status
	require("checkLogin.php");
	
    if (isset($adminID)) {
        db_upd("fl_admins", "adminName='$adminName', adminPassword='$adminPassword'", "adminID='$adminID'", __FILE__, __LINE__);
        //db_del("fl_apps_admin_to_apps", "adminID='$adminID' && appID='$appID'", __FILE__, __LINE__); // reset admin to app assignments (delete)
    } else {
        db_ins("fl_admins", "adminName, adminPassword", "'$adminName', '$adminPassword'", __FILE__, __LINE__);
    }

    // set admin to app assignments (insert) -- for Beta 2
    /* foreach ($_GET as $key => $value) {
        if (strpos($key, "app") !== false) {
            $appID = substr($key, 5);
            db_ins("fl_apps_admin_to_apps", "appID, adminID, appID", "'$appID', '$adminID', '$appID'", __FILE__, __LINE__);
        }
    } */

    echo "1";
?>