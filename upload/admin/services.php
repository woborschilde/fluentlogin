<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2018 woborschil.de

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

	// Establish database connection
	require_once(__DIR__ . "/../lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

	// Check admin login status
	require("functions/checkLogin.php");

	db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

	$key = 0;

	// Get services of app
	$query = $conn->query("SELECT * FROM fl_apps_services WHERE appID='$appID' ORDER BY appID ASC");
	while ($row = $query->fetch_assoc()) {
		$serviceID = $row["serviceID"];
		$serviceName = $row["serviceName"];

		$keys[] = $key; $key++;
		$serviceIDs[] = $serviceID;
		$serviceNames[] = $serviceName;
	}

	if ($query->num_rows == 0) {
		$keys[] = $key;
		$serviceIDs[] = "-";
		$serviceNames[] = "No services created yet.";
	}

	// Template hooks
	require("functions/initHooks.php");
	initHooks("fields");

	// Assign variables to smarty
	$smarty->assign("keys", $keys);
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
	$smarty->assign("adminName", $adminName);
	$smarty->assign("serviceIDs", $serviceIDs);
	$smarty->assign("serviceNames", $serviceNames);

	$smarty->display("templates/services.tpl");
?>
