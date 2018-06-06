<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2018 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

	// Include Smarty Template Engine
	require(__DIR__ . "/../lib/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;

	if (isset($_GET["appID"])) {
		$appID = $_GET["appID"];
		$actionName = "($appID) Edit";
	} else {
		$appID = 0;
		$actionName = "Add";
	}

	// Establish database connection
	require_once(__DIR__ . "/../lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

	// Check admin login status
	require("functions/checkLogin.php");

	// Get app details
	if ($appID > 0) {
		db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);
	} else {
		$appName = "";
	}

	$key = 0;

	// Get settings of app
	$query0 = $conn->query("SELECT settingID, settingName, settingDefault FROM fl_appsettings ORDER BY settingID ASC");
	$num_rows0 = $query0->num_rows;
	while ($row0 = $query0->fetch_assoc()) {
		$settingID = $row0["settingID"];
		$settingName = $row0["settingName"];
		$settingDefault = $row0["settingDefault"];

		$keys[] = $key; $key++;
		$settingIDs[] = $settingID;
		$settingNames[] = $settingName;

		// Get setting values for user
		$query1 = $conn->query("SELECT settingValue FROM fl_appsettings_values WHERE settingID='$settingID' && appID='$appID'");
		while ($row1 = $query1->fetch_assoc()) {
			$settingValues[] = $row1["settingValue"];
		}

		if ($query1->num_rows == 0) {
			$settingValues[] = $settingDefault;
		}
		//
	}

	if ($num_rows0 == 0) {
		$keys[] = $key;
		$settingIDs[] = "-";
		$settingNames[] = "No further settings available.";
		$settingValues[] = "";
	}

	// Template hooks
	require("functions/initHooks.php");
	initHooks("apps");

	// Assign variables to smarty
	$smarty->assign("appID", $appID);
	$smarty->assign("adminName", $adminName);
	$smarty->assign("actionName", $actionName);
	$smarty->assign("appName", $appName);

	$smarty->assign("keys", $keys);
	$smarty->assign("settingIDs", $settingIDs);
	$smarty->assign("settingNames", $settingNames);
	$smarty->assign("settingValues", $settingValues);

	$smarty->display("templates/appEdit.tpl");
?>
