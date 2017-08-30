<?php
	// Include Smarty Template Engine
	require("/usr/local/installed/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;

	if (isset($_GET["appID"])) {
		$appID = $_GET["appID"];
	} else {
		die("Argument ''appID'' is required!");
	}

	// Establish database connection
	require("/var/www/unscramblephp/Unscramble.php");
    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);
	
	db_san($_GET);

	// Check user login status
	$embed = 1;
	$redirect = "settings.php";
	require("functions/checkLogin.php");

	db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

	// Assign variables to smarty
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
	$smarty->assign("userID", $userID);
	
	$smarty->display("templates/settings.tpl");
?>