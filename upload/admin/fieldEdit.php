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

	if (isset($_GET["fieldID"])) {
		$fieldID = $_GET["fieldID"];
		$actionName = "($fieldID) Edit";
	} else {
		$fieldID = 0;
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

	if ($fieldID > 0) {
		db_sel("fieldName, fieldDescription, showOnLogin, showOnRegister", "fl_apps_fields", "appID='$appID' && fieldID='$fieldID'", __FILE__, __LINE__);
	} else {
		$fieldName = "";
		$fieldDescription = "";
		$showOnLogin = "";
		$showOnRegister = "";
	}

	if ($showOnLogin == "1") {
		$showOnLogin = "checked";
	} else {
		$showOnLogin = "";
	}

	if ($showOnRegister == "1") {
		$showOnRegister = "checked";
	} else {
		$showOnRegister = "";
	}

	// Assign variables to smarty
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
	$smarty->assign("adminName", $adminName);
	$smarty->assign("fieldID", $fieldID);
	$smarty->assign("actionName", $actionName);
	$smarty->assign("fieldName", $fieldName);
	$smarty->assign("fieldDescription", $fieldDescription);
	$smarty->assign("showOnLogin", $showOnLogin);
	$smarty->assign("showOnRegister", $showOnRegister);
	
	$smarty->display("templates/fieldEdit.tpl");
?>