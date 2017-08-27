<?php
	// Include Smarty Template Engine
	require("/usr/local/installed/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;

	if (isset($_GET["appID"])) {
		$appID = $_GET["appID"];
	} else {
		die("Argument ''appID'' is required!");
	}

	if (isset($_GET["groupID"])) {
		$groupID = $_GET["groupID"];
		$actionName = "($groupID) Edit";
	} else {
		$groupID = 0;
		$actionName = "Add";
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

	if ($groupID > 0) {
		db_sel("groupName, groupDescription", "fl_apps_groups", "groupID='$groupID'", __FILE__, __LINE__);
	} else {
		$groupName = "";
		$groupDescription = "";
	}

	$key = 0;
	
	// Get permissions of app
	$query = $conn->query("SELECT * FROM fl_apps_permissions WHERE appID='$appID' ORDER BY permName ASC");
	while ($row = $query->fetch_assoc()) {
		$permID = $row["permID"];
		$permName = $row["permName"];

		$keys[] = $key; $key++;
		$permIDs[] = $permID;
		$permNames[] = $permName;

		// Get permission values of group
		$query1 = $conn->query("SELECT value FROM fl_apps_perms_values WHERE permID='$permID' && groupID='$groupID' && appID='$appID' ORDER BY valueID ASC");
		while ($row1 = $query1->fetch_assoc()) {
			$permValue = $row1["value"];

			if ($permValue == "1") {
				$permValue = "checked";  // due to HTML specification - checked must be set or omitted
			} else {
				$permValue = "";
			}

			$permValues[] = $permValue;
		}

		if ($query1->num_rows == 0) {
			$permValues[] = "";
		}
		//
	}

	if ($query->num_rows == 0) {
		$keys[] = $key;
		$permIDs[] = "-";
		$permNames[] = "No permissions created yet.";
		$permValues[] = "";
	}

	// Assign variables to smarty
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
	$smarty->assign("groupID", $groupID);
	$smarty->assign("actionName", $actionName);
	$smarty->assign("groupName", $groupName);
	$smarty->assign("groupDescription", $groupDescription);

	$smarty->assign("keys", $keys);
	$smarty->assign("permIDs", $permIDs);
	$smarty->assign("permNames", $permNames);
	$smarty->assign("permValues", $permValues);
	
	$smarty->display("templates/groupEdit.tpl");
?>