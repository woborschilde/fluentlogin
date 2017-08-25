<?php
	// Include Smarty Template Engine
	require("/usr/local/installed/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;
	
	if (isset($_GET["appID"])) {
		$appID = $_GET["appID"];
	} else {
		die("Argument ''appID'' is required!");
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

	if ($num_rows == 0) {
		die("An app with ID $appID does not exist!");
	}

    db_sel("settingValue", "fl_apps_settings", "appID='$appID' && settingName='license'", __FILE__, __LINE__);

	if ($num_rows > 0) {
		$license = $settingValue;
	} else {
		$license = "The administrator did not set up any terms of use.";
	}

	// Assign variables to smarty
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);

    $smarty->assign("license", $license);
	
	$smarty->display("license.tpl");
?>