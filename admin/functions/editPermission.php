<?php
    require("../../lib/unsphp/Unscramble.php");

	$appID = $_GET["appID"];
    
	if ($_GET["permissionID"] != "0") {
		$permissionID = $_GET["permissionID"];
	}

    $permissionName = $_GET["permissionName"];
    $permissionDescription = $_GET["permissionDescription"];

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

	// Check admin login status
	require("checkLogin.php");
	
    if (isset($permissionID)) {
        db_upd("fl_apps_permissions", "permName='$permissionName', permDescription='$permissionDescription'", "permID='$permissionID'", __FILE__, __LINE__);
    } else {
        // deprecated:
        //db_get_ai($db_database, "fl_apps_permissions", __FILE__, __LINE__);
        //$permissionID = $ai;
        
        db_ins("fl_apps_permissions", "appID, permName, permDescription", "'$appID', '$permissionName', '$permissionDescription'", __FILE__, __LINE__);
        
        // deprecated:
        //$conn->query("ALTER TABLE fl_apps_groups ADD perm$appID" . "_$permissionID tinyint(1) NOT NULL DEFAULT '0'");
    }

    echo "1";
?>