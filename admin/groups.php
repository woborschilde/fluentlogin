<?php
	// Include Smarty Template Engine
	require("/usr/local/installed/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;
	
	if (isset($_GET["appID"])) {
		$appID = $_GET["appID"];
	} else {
		die("Argument ''appID'' is required!");
	}

	// Check user login status
	//include("functions/checkLogin.php");
	
	// Load Sidenav
	//include("functions/loadSidenav.php");
	
	// Establish database connection
	require("/var/www/unscramblephp/Unscramble.php");
    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);
	
	db_san($_GET);
	
	db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

	$key = 0;
	
	// Get accounts of user
	$query = $conn->query("SELECT * FROM fl_apps_groups WHERE appID='$appID' ORDER BY appID ASC");
	while ($row = $query->fetch_assoc()) {
		$groupID = $row["groupID"];
		$groupName = $row["groupName"];

		$keys[] = $key; $key++;
		$groupIDs[] = $groupID;
		$groupNames[] = $groupName;
	}

	if ($query->num_rows == 0) {
		$keys[] = $key;
		$groupIDs[] = "-";
		$groupNames[] = "No user groups created yet.";
	}

	// Assign variables to smarty
	$smarty->assign("keys", $keys);
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
	$smarty->assign("groupIDs", $groupIDs);
	$smarty->assign("groupNames", $groupNames);
	
	$smarty->display("templates/groups.tpl");
?>