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

	db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

	if ($num_rows == 0) {
		die("An app with ID $appID does not exist!");
	}

	// Check user login status
	$embed = 1;
	require("functions/checkLogin.php");

	$jskey = 0;
	$num_rows_total = 0;

    // Get service provider optional JavaScript code
	$query = $conn->query("SELECT serviceType FROM fl_apps_services WHERE appID='$appID'");
	$num_rows = $query->num_rows;
	while ($row = $query->fetch_assoc()) {
		$typeName = $row["serviceType"];

		$query1 = $conn->query("SELECT typeID FROM fl_servicetypes WHERE typeName='$typeName'");
		while ($row1 = $query1->fetch_assoc()) {
			$typeID = $row1["typeID"];
		}

		$query1 = $conn->query("SELECT stjsActionName FROM fl_servicetypes_js WHERE typeID='$typeID' && stjsActionName='doLogout'");
		$num_rows1 = $query1->num_rows;
		while ($row1 = $query1->fetch_assoc()) {
			$actionName = $row1["stjsActionName"];

			$jskeys[] = $jskey; $jskey++;
			$jsTypeNames[] = $typeName;
			$jsActionNames[] = $actionName;
			$jsActionContent[] = file_get_contents("plugins/service.$typeName/js/$actionName.tpl");

			$num_rows_total++;
		}
	}

	if ($num_rows == 0 || $num_rows_total == 0) {
		$jskeys[] = $jskey;
		$jsTypeNames[] = "";
		$jsActionNames[] = "";
		$jsActionContent[] = "";
	}

	// Get service provider fields
	require("functions/initServiceProviders.php");
    initServiceProviders("doLogout", true, true);

	// Get style (colors, etc.)
	require("functions/getStyle.php");

	// Assign variables to smarty
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
	$smarty->assign("redirect", $redirect);

	$smarty->assign("jskeys", $jskeys);
	$smarty->assign("jsTypeNames", $jsTypeNames);
	$smarty->assign("jsActionNames", $jsActionNames);
	$smarty->assign("jsActionContent", $jsActionContent);

	$smarty->display("templates/logout.tpl");
?>
