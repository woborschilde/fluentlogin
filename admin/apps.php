<?php
	// Include Smarty Template Engine
	require("/usr/local/installed/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;
	
	// Check user login status
	//include("functions/checkLogin.php");
	
	// Load Sidenav
	//include("functions/loadSidenav.php");
	
	// Establish database connection
	require("/var/www/unscramblephp/Unscramble.php");
    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);
	
	$key = 0;
	
	// Get accounts of user
	$query = $conn->query("SELECT * FROM fl_apps ORDER BY appID ASC");
	while ($row = $query->fetch_assoc()) {
		$appID = $row["appID"];
		$appName = $row["appName"];

		$keys[] = $key; $key++;
		$appIDs[] = $appID;
		$appNames[] = $appName;
	}

	if ($query->num_rows == 0) {
		$keys[] = $key;
		$appIDs[] = "-";
		$appNames[] = "No apps created yet.";
	}

	// Assign variables to smarty
	$smarty->assign("keys", $keys);
	$smarty->assign("appIDs", $appIDs);
	$smarty->assign("appNames", $appNames);
	
	$smarty->display("templates/apps.tpl");
?>