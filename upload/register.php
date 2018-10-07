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

	if (isset($_GET["redirect"])) {
		$redirect = $_GET["redirect"];
	} else {
		$redirect = "index.php?appID=$appID";
	}

	// Establish database connection
	require("lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

	// Check user login status
	$embed = 1;
	$invert = 1;  // redirect to user panel if logged in - no infinite loop
	require("functions/checkLogin.php");

	db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

	if ($num_rows == 0) {
		die("An app with ID $appID does not exist!");
	}

	// get if registration is enabled for this app
	db_sel("settingID", "fl_appsettings", "settingName='registration'", __FILE__, __LINE__);
	db_sel("NULL", "fl_appsettings_values", "appID='$appID' && settingID='$settingID' && settingValue='on'", __FILE__, __LINE__);

	if ($num_rows > 0) {
		$registrationEnabled = "1";
	} else {
		$registrationEnabled = "0";
	}
	//

	$key = 0;

    // Get showOnLogin fields
	$query = $conn->query("SELECT fieldID, fieldName FROM fl_apps_fields WHERE appID='$appID' && showOnRegister='1' ORDER BY fieldName ASC");
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

	$jskey = 0;
	$num_rows_total = 0;

    // Get service provider optional JavaScript code
	$query = $conn->query("SELECT serviceName, serviceType FROM fl_apps_services WHERE appID='$appID'");
	$num_rows = $query->num_rows;
	while ($row = $query->fetch_assoc()) {
		$serviceName = $row["serviceName"];
		$typeName = $row["serviceType"];

		$query1 = $conn->query("SELECT typeID FROM fl_servicetypes WHERE typeName='$typeName'");
		while ($row1 = $query1->fetch_assoc()) {
			$typeID = $row1["typeID"];
		}

		$query1 = $conn->query("SELECT stjsActionName FROM fl_servicetypes_js WHERE typeID='$typeID' && stjsActionName='doRegister'");
		$num_rows1 = $query1->num_rows;
		while ($row1 = $query1->fetch_assoc()) {
			$actionName = $row1["stjsActionName"];

			$jskeys[] = $jskey; $jskey++;
			$jsServiceNames[] = $serviceName;
			$jsTypeNames[] = $typeName;
			$jsActionNames[] = $actionName;
			$jsActionContent[] = file_get_contents("plugins/service.$typeName/js/$actionName.tpl");

			$num_rows_total++;
		}
	}

	if ($num_rows == 0 || $num_rows_total == 0) {
		$jskeys[] = $jskey;
		$jsServiceNames[] = "";
		$jsTypeNames[] = "";
		$jsActionNames[] = "";
		$jsActionContent[] = "";
	}

	// Get service provider fields
	require("functions/initServiceProviders.php");
    initServiceProviders("doRegister", true, true, true);

	// Get style (colors, etc.)
	require("functions/getStyle.php");

	// Assign variables to smarty
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
	$smarty->assign("redirect", $redirect);
	$smarty->assign("registrationEnabled", $registrationEnabled);

	$smarty->assign("keys", $keys);
	$smarty->assign("fieldIDs", $fieldIDs);
	$smarty->assign("fieldNames", $fieldNames);

	$smarty->assign("jskeys", $jskeys);
	$smarty->assign("jsServiceNames", $jsServiceNames);
	$smarty->assign("jsTypeNames", $jsTypeNames);
	$smarty->assign("jsActionNames", $jsActionNames);
	$smarty->assign("jsActionContent", $jsActionContent);

	$smarty->display("templates/register.tpl");
?>
