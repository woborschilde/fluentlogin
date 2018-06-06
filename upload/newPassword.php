<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2018 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

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
		$redirect = "settings.php";
	}

	if (isset($_GET["noredirect"])) {
		$noredirect = $_GET["noredirect"];
	} else {
		$noredirect = 0;
	}

	// Establish database connection
	require("lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

	db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

	if ($num_rows == 0) {
		die("An app with ID $appID does not exist!");
	}

	// Check user login status
	$embed = 1;
	$invert = 1;  // redirect to user panel if logged in - no infinite loop
	require("functions/checkLogin.php");

	// Get style (colors, etc.)
	require("functions/getStyle.php");

	// Assign variables to smarty
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
	$smarty->assign("redirect", $redirect);

	$smarty->assign("userID", $userID);

	$smarty->display("templates/newPassword.tpl");
?>
