<?php
	// Include Smarty Template Engine
	require("/usr/local/installed/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;
	
	if (isset($_GET["appID"])) {
		$appID = $_GET["appID"];
	} else {
		die("Argument ''appID'' is required!");
	}
	
	// Establish database connection
	require("/var/www/unscramblephp/Unscramble.php");
    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);
	
	db_san($_GET);

	// Check admin login status
	require("functions/checkLogin.php");
	
	db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

	$key = 0;
	
	// Get users of app
	$query = $conn->query("SELECT * FROM fl_apps_users WHERE appID='$appID' ORDER BY appID ASC");
	while ($row = $query->fetch_assoc()) {
		$userID = $row["userID"];
		$userName = $row["userName"];

		$keys[] = $key; $key++;
		$userIDs[] = $userID;
		$userNames[] = $userName;
	}

	if ($query->num_rows == 0) {
		$keys[] = $key;
		$userIDs[] = "-";
		$userNames[] = "No users created yet.";
	}

	// Assign variables to smarty
	$smarty->assign("keys", $keys);
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
	$smarty->assign("adminName", $adminName);
	$smarty->assign("userIDs", $userIDs);
	$smarty->assign("userNames", $userNames);
	
	$smarty->display("templates/users.tpl");
?>