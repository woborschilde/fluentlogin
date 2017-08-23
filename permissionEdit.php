<?php
	// Include Smarty Template Engine
	require("/usr/local/installed/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;

	if (isset($_GET["appID"])) {
		$appID = $_GET["appID"];
	} else {
		die("Argument ''appID'' is required!");
	}

	if (isset($_GET["permissionID"])) {
		$permissionID = $_GET["permissionID"];
		$actionName = "bearbeiten";
	} else {
		$permissionID = 0;
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

	if ($permissionID > 0) {
		db_sel("permName, permDescription", "fl_apps_permissions", "appID='$appID' && permID='$permissionID'", __FILE__, __LINE__);
	} else {
		$permName = "";
		$permDescription = "";
	}

	// Assign variables to smarty
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
	$smarty->assign("permissionID", $permissionID);
	$smarty->assign("actionName", $actionName);
	$smarty->assign("permissionName", $permName);
	$smarty->assign("permissionDescription", $permDescription);
	
	$smarty->display("permissionEdit.tpl");
?>