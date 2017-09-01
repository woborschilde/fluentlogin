<?php
	// Include Smarty Template Engine
	require("../lib/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;
	
	if (isset($_GET["appID"])) {
		$appID = $_GET["appID"];
	} else {
		die("Argument ''appID'' is required!");
	}
	
	// Establish database connection
	require("../lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);
	
	db_san($_GET);

	// Check admin login status
	require("functions/checkLogin.php");
	
	// Load system settings
	require("functions/loadSettings.php");

	db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

	$key = 0;
	
	// Get accounts of user
	$query = $conn->query("SELECT * FROM fl_apps_fields WHERE appID='$appID' ORDER BY appID ASC");
	while ($row = $query->fetch_assoc()) {
		$fieldID = $row["fieldID"];
		$fieldName = $row["fieldName"];

		$keys[] = $key; $key++;
		$fieldIDs[] = $fieldID;
		$fieldNames[] = $fieldName;
	}

	if ($query->num_rows == 0) {
		$keys[] = $key;
		$fieldIDs[] = "-";
		$fieldNames[] = "No fields created yet.";
	}

	// Assign variables to smarty
	$smarty->assign("keys", $keys);
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
	$smarty->assign("adminName", $adminName);
	$smarty->assign("fieldIDs", $fieldIDs);
	$smarty->assign("fieldNames", $fieldNames);
	
	$smarty->display("templates/fields.tpl");
?>