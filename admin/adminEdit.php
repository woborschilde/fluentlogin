<?php
	// Include Smarty Template Engine
	require("../lib/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;

	if (isset($_GET["adminID"])) {
		$adminID = $_GET["adminID"];
		$actionName = "($adminID) Edit";
	} else {
		$adminID = 0;
		$actionName = "Add";
	}
	
	// Establish database connection
	require("../lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);
	
	db_san($_GET);

	// Check admin login status
	require("functions/checkLogin.php");

	if ($adminID > 0) {
		db_sel("adminName, adminPassword", "fl_admins", "adminID='$adminID'", __FILE__, __LINE__);
		$adminNameField = $adminName;
	} else {
		$adminNameField = "";
		$adminPassword = "";
	}

	$key = 0;

	/* // Get apps assigned to admin -- for Beta 2
	$query0 = $conn->query("SELECT appID, appName FROM fl_apps_apps WHERE appID='$appID' ORDER BY appName ASC");
	$num_rows0 = $query0->num_rows;
	while ($row0 = $query0->fetch_assoc()) {
		$appID = $row0["appID"];
		$appName = $row0["appName"];

		$keys[] = $key; $key++;
		$appIDs[] = $appID;
		$appNames[] = $appName;

		// Get admin to apps
		db_sel("NULL", "fl_apps_admin_to_apps", "appID='$appID' && adminID='$adminID' && appID='$appID'", __FILE__, __LINE__);

		if ($num_rows > 0) {
			$appValues[] = "checked";
		} else {
			$appValues[] = "";
		}
		//
	}
	
	if ($num_rows0 == 0) {
		$keys[] = $key;
		$appIDs[] = "-";
		$appNames[] = "No admin apps created yet.";
		$appValues[] = "";
	} */

	// Assign variables to smarty
	$smarty->assign("adminID", $adminID);
	$smarty->assign("actionName", $actionName);
	$smarty->assign("adminName", $adminName);  // from checkLogin
	$smarty->assign("adminNameField", $adminNameField);
	$smarty->assign("adminPassword", $adminPassword);

	// $smarty->assign("keys", $keys);
	// $smarty->assign("groupIDs", $groupIDs);
	// $smarty->assign("groupNames", $groupNames);
	// $smarty->assign("groupValues", $groupValues);
	
	$smarty->display("templates/adminEdit.tpl");
?>