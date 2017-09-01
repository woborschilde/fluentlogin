<?php
	// Include Smarty Template Engine
	require("lib/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;
	
	if (isset($_GET["appID"])) {
		$appID = $_GET["appID"];
	} else {
		die("Argument ''appID'' is required!");
	}

	$userID = $_GET["userID"];

	if (isset($_GET["redirect"])) {
		$redirect = $_GET["redirect"];
	} else {
		$redirect = "index.php";
	}

	// Establish database connection
	require("lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);
	
	db_san($_GET);
	
	// Check user login status
	$embed = 1;
	$redirect = "newPassword.php";
	require("functions/checkLogin.php");

	db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

	if ($num_rows == 0) {
		die("An app with ID $appID does not exist!");
	}

	// Assign variables to smarty
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
	$smarty->assign("redirect", $redirect);
	
	$smarty->assign("userID", $userID);

	$smarty->display("templates/newPassword.tpl");
?>