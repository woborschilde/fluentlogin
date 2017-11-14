<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
	// Include Smarty Template Engine
	require("lib/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;
	
	// Establish database connection
	require("lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);
	
	db_san($_GET);
	
	// Load system settings
	require_once(__DIR__ . "/admin/functions/loadSettings.php");
 
	getVariable("appID", "die");
	getVariable("redirect", "index.php");

	db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

	if ($num_rows == 0) {
		die("An app with ID $appID does not exist!");
	}

	// Check user login status
	$embed = 1;
	$invert = 1;  // redirect to user panel if logged in - no infinite loop
	require("functions/checkLogin.php");

    $key = 0;

    // Get showOnLogin fields
	$query = $conn->query("SELECT fieldID, fieldName FROM fl_apps_fields WHERE appID='$appID' && showOnLogin='1' ORDER BY fieldName ASC");
	$num_rows = $query->num_rows;
	while ($row = $query->fetch_assoc()) {
		$fieldID = $row["fieldID"];
		$fieldName = $row["fieldName"];

		$keys[] = $key; $key++;
		$fieldIDs[] = $fieldID;
		$fieldNames[] = $fieldName;
	}
	
	if ($num_rows == 0) {
		$keys[] = $key;
		$fieldIDs[] = "";
		$fieldNames[] = "";
	}

	// Assign variables to smarty
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
	$smarty->assign("redirect", $redirect);

    $smarty->assign("keys", $keys);
	$smarty->assign("fieldIDs", $fieldIDs);
	$smarty->assign("fieldNames", $fieldNames);
	
	$smarty->display("templates/login.tpl");
?>