<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

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
	
	// Establish database connection
	require("lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);
	
	db_san($_GET);
	
	db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

	if ($num_rows == 0) {
		die("An app with ID $appID does not exist!");
	}

	db_sel("settingID", "fl_appsettings", "settingName='license'", __FILE__, __LINE__);
    db_sel("settingValue", "fl_appsettings_values", "appID='$appID' && settingID='$settingID'", __FILE__, __LINE__);

	if ($num_rows > 0) {
		$license = $settingValue;
	} else {
		$license = "The administrator did not set up any terms of use.";
	}

	// Get style (colors, etc.)
	require("functions/getStyle.php");

	// Assign variables to smarty
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);

    $smarty->assign("license", $license);
	
	$smarty->display("templates/license.tpl");
?>