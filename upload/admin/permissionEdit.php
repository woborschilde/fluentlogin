<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

	// Include Smarty Template Engine
	require(__DIR__ . "/../lib/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;

	if (isset($_GET["appID"])) {
		$appID = $_GET["appID"];
	} else {
		die("Argument ''appID'' is required!");
	}

	if (isset($_GET["permissionID"])) {
		$permissionID = $_GET["permissionID"];
		$actionName = "($permissionID) Edit";
	} else {
		$permissionID = 0;
		$actionName = "Add";
	}

	// Establish database connection
	require_once(__DIR__ . "/../lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

	// Check admin login status
	require("functions/checkLogin.php");

	db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

	if ($permissionID > 0) {
		db_sel("permName, permDescription", "fl_apps_permissions", "appID='$appID' && permID='$permissionID'", __FILE__, __LINE__);
	} else {
		$permName = "";
		$permDescription = "";
	}

	// Template hooks
	require("functions/initHooks.php");
	initHooks("apps");

	// Assign variables to smarty
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
	$smarty->assign("adminName", $adminName);
	$smarty->assign("permissionID", $permissionID);
	$smarty->assign("actionName", $actionName);
	$smarty->assign("permissionName", $permName);
	$smarty->assign("permissionDescription", $permDescription);

	$smarty->display("templates/permissionEdit.tpl");
?>
