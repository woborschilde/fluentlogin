<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

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

	if (isset($_GET["serviceID"])) {
		$serviceID = $_GET["serviceID"];
		$actionName = "($serviceID) Edit";
	} else {
		$serviceID = 0;
		$actionName = "Add";
	}

	// Establish database connection
	require_once(__DIR__ . "/../lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

	// Check admin login status
	require("functions/checkLogin.php");

	db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

	if ($serviceID > 0) {
		db_sel("*", "fl_apps_services", "appID='$appID' && id='$serviceID'", __FILE__, __LINE__);
	} else {
		$serviceName = "";
		$serviceType = "";
		$serviceDatabase = "";
		$serviceTablePrefix = "";
	}

	$key = 0;

	// Get service types
	$query = $conn->query("SELECT * FROM fl_apps_servicetypes ORDER BY typeFullName ASC");
	while ($row = $query->fetch_assoc()) {
		$typeID = $row["id"];
		$typeName = $row["typeName"];
		$typeFullName= $row["typeFullName"];

		$keys[] = $key; $key++;
		$typeIDs[] = $typeID;
		$typeNames[] = $typeName;
		$typeFullNames[] = $typeFullName;
	}

	if ($key == 0) {
		die("Es sind keine Serviceprovider installiert.<br /><a href='javascript:history.back();'>Zurück</a>");
	}

	// Template hooks
	require("functions/initHooks.php");
	initHooks("apps");

	// Assign variables to smarty
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
	$smarty->assign("adminName", $adminName);
	$smarty->assign("serviceID", $serviceID);
	$smarty->assign("actionName", $actionName);
	$smarty->assign("serviceName", $serviceName);
	$smarty->assign("serviceType", $serviceType);
	$smarty->assign("serviceDatabase", $serviceDatabase);
	$smarty->assign("serviceTablePrefix", $serviceTablePrefix);

	$smarty->assign("keys", $keys);
	$smarty->assign("typeIDs", $typeIDs);
	$smarty->assign("typeNames", $typeNames);
	$smarty->assign("typeFullNames", $typeFullNames);

	$smarty->display("templates/serviceEdit.tpl");
?>
