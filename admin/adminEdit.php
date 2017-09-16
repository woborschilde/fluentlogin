<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
	// Include Smarty Template Engine
	require("../lib/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;
	
	if (isset($_GET["adminID"])) {
		$adminIDField = $_GET["adminID"];
		$actionName = "($adminIDField) Edit";
	} else {
		$adminIDField = 0;
		$actionName = "Add";
	}
	
	// Establish database connection
	require("../lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);
	
	db_san($_GET);

	// Check admin login status
	if (isset($_GET["sos"])) {
		$sos = "&sos=1";  // allow access even without login -> for admin password reset
	} else {
		$sos = "";
	}
	$sosok = 0;  // SOS granted by checkLogin.php?
	require("functions/checkLogin.php");

	$selfWarning = 0;

	if ($adminIDField > 0) {
		db_sel("adminName, adminPassword", "fl_admins", "adminID='$adminIDField'", __FILE__, __LINE__);
		$adminNameField = $adminName;

		if ($adminIDField == $adminID) {
			$selfWarning = 1;
		}
	} else {
		$adminNameField = "";
		$adminPassword = "";
	}

	// Check admin login status -- double import because of variable naming issues
	require("functions/checkLogin.php");

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
	$smarty->assign("adminID", $adminID); // from checkLogin
	$smarty->assign("adminIDField", $adminIDField);
	$smarty->assign("actionName", $actionName);
	$smarty->assign("adminName", $adminName);  // from checkLogin
	$smarty->assign("adminNameField", $adminNameField);
	$smarty->assign("adminPassword", $adminPassword);
	$smarty->assign("selfWarning", $selfWarning);
	$smarty->assign("sos", $sos);
	$smarty->assign("sosok", $sosok);

	// $smarty->assign("keys", $keys);
	// $smarty->assign("groupIDs", $groupIDs);
	// $smarty->assign("groupNames", $groupNames);
	// $smarty->assign("groupValues", $groupValues);
	
	$smarty->display("templates/adminEdit.tpl");
?>