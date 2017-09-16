<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
	// Include Smarty Template Engine
	require("../lib/smarty/app/fluentlogin/smartyInclude.php");
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
	
	// Establish database connection
	require("../lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);
	
	db_san($_GET);

	// Check admin login status
	require("functions/checkLogin.php");
	
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
		$query1 = $conn->query("SELECT permValue FROM fl_apps_perms_values WHERE permID='$permID' && groupID='$groupID' && appID='$appID' ORDER BY valueID ASC");
		while ($row1 = $query1->fetch_assoc()) {
			$permValue = $row1["permValue"];

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
	$smarty->assign("adminName", $adminName);
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