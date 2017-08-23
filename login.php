<?php
	// Include Smarty Template Engine
	require("/usr/local/installed/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;
	
	if (isset($_GET["appID"])) {
		$appID = $_GET["appID"];
	} else {
		die("Argument ''appID'' is required!");
	}

	if (isset($_GET["redirect"])) {
		$redirect = $_GET["redirect"];
	} else {
		$redirect = "index.php";
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
	
	$smarty->display("login.tpl");
?>