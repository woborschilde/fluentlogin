<?php
	// Include Smarty Template Engine
	require("/usr/local/installed/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;

	if (isset($_GET["appID"])) {
		$appID = $_GET["appID"];
	} else {
		die("Argument ''appID'' is required!");
	}

	if (isset($_GET["fieldID"])) {
		$fieldID = $_GET["fieldID"];
		$actionName = "bearbeiten";
	} else {
		$fieldID = 0;
		$actionName = "hinzufügen";
	}

	// Check user login status
	//include("functions/checkLogin.php");
	
	// Load Sidenav
	//include("functions/loadSidenav.php");
	
	// Establish database connection
	require("/var/www/unscramblephp/Unscramble.php");
    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);
	
	db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

	if ($fieldID > 0) {
		db_sel("fieldName, fieldDescription, showOnLogin", "fl_apps_fields", "appID='$appID' && fieldID='$fieldID'", __FILE__, __LINE__);
	} else {
		$fieldName = "";
		$fieldDescription = "";
		$showOnLogin = "";
	}

	if ($showOnLogin == "1") {
		$showOnLogin = "checked";
	} else {
		$showOnLogin = "";
	}

	// Assign variables to smarty
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
	$smarty->assign("fieldID", $fieldID);
	$smarty->assign("actionName", $actionName);
	$smarty->assign("fieldName", $fieldName);
	$smarty->assign("fieldDescription", $fieldDescription);
	$smarty->assign("showOnLogin", $showOnLogin);
	
	$smarty->display("fieldEdit.tpl");
?>