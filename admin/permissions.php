<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
	// Include Smarty Template Engine
	require("../lib/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;
	
	if (isset($_GET["appID"])) {
		$appID = $_GET["appID"];
	} else {
		die("Argument ''appID'' is required!");
	}
	
	// Establish database connection
	require("../lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);
	
	db_san($_GET);

	// Check admin login status
	require("functions/checkLogin.php");
	
	db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

	$key = 0;
	
	// Get accounts of user
	$query = $conn->query("SELECT * FROM fl_apps_permissions WHERE appID='$appID' ORDER BY appID ASC");
	while ($row = $query->fetch_assoc()) {
		$permissionID = $row["permID"];
		$permissionName = $row["permName"];

		$keys[] = $key; $key++;
		$permissionIDs[] = $permissionID;
		$permissionNames[] = $permissionName;
	}

	if ($query->num_rows == 0) {
		$keys[] = $key;
		$permissionIDs[] = "-";
		$permissionNames[] = "No permissions created yet.";
	}

	// Assign variables to smarty
	$smarty->assign("keys", $keys);
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
	$smarty->assign("adminName", $adminName);
	$smarty->assign("permissionIDs", $permissionIDs);
	$smarty->assign("permissionNames", $permissionNames);
	
	$smarty->display("templates/permissions.tpl");
?>