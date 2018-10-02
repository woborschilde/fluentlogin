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

	if (isset($_GET["featureID"])) {
		$featureID = $_GET["featureID"];
		$actionName = "($featureID) Edit";
	} else {
		$featureID = 0;
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

	if ($featureID > 0) {
		db_sel("target, text, icon, iconColor, position", "fl_apps_features", "featureID='$featureID'", __FILE__, __LINE__);
	} else {
		db_get_ai($db_database, "fl_apps_features", __FILE__, __LINE__);

		$target = "";
		$text = "";
		$icon = "link";
		$iconColor = "525252";
		$position = $ai + 1;
	}

	$key = 0;

	// Get groups of app
	$query = $conn->query("SELECT * FROM fl_apps_groups WHERE appID='$appID' ORDER BY groupName ASC");
	while ($row = $query->fetch_assoc()) {
		$groupID = $row["groupID"];
		$groupName = $row["groupName"];

		$keys[] = $key; $key++;
		$groupIDs[] = $groupID;
		$groupNames[] = $groupName;

		// Get group assigments of feature
		$groupValue = "";

		$query1 = $conn->query("SELECT NULL FROM fl_apps_features_values WHERE `type`='group' && recordID='$groupID' && featureID='$featureID' && appID='$appID'");
		while ($row1 = $query1->fetch_assoc()) {
			$groupValue = "checked";  // due to HTML specification - checked must be set or omitted
		}

		$groupValues[] = $groupValue;
		//
	}

	if ($query->num_rows == 0) {
		$keys[] = $key;
		$groupIDs[] = "-";
		$groupNames[] = "No groups created yet.";
		$groupValues[] = "";
	}

	$key = 0;

	// Get users of app
	$query = $conn->query("SELECT * FROM fl_apps_users WHERE appID='$appID' ORDER BY userName ASC");
	while ($row = $query->fetch_assoc()) {
		$userID = $row["userID"];
		$userName = $row["userName"];

		$keys2[] = $key; $key++;
		$userIDs[] = $userID;
		$userNames[] = $userName;

		// Get user assigments of feature
		$userValue = "";

		$query1 = $conn->query("SELECT NULL FROM fl_apps_features_values WHERE `type`='user' && recordID='$userID' && featureID='$featureID' && appID='$appID'");
		while ($row1 = $query1->fetch_assoc()) {
			$userValue = "checked";  // due to HTML specification - checked must be set or omitted
		}

		$userValues[] = $userValue;
		//
	}

	if ($query->num_rows == 0) {
		$keys2[] = $key;
		$userIDs[] = "-";
		$userNames[] = "No users created yet.";
		$userValues[] = "";
	}

	// Template hooks
	require("functions/initHooks.php");
	initHooks("apps");

	// Assign variables to smarty
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
	$smarty->assign("adminName", $adminName);

	$smarty->assign("featureID", $featureID);
	$smarty->assign("actionName", $actionName);

	$smarty->assign("shortcutTarget", $target);
	$smarty->assign("shortcutText", $text);
	$smarty->assign("shortcutIcon", $icon);
	$smarty->assign("shortcutIconColor", $iconColor);
	$smarty->assign("shortcutPosition", $position);

	$smarty->assign("keys", $keys);
	$smarty->assign("groupIDs", $groupIDs);
	$smarty->assign("groupNames", $groupNames);
	$smarty->assign("groupValues", $groupValues);

	$smarty->assign("keys2", $keys2);
	$smarty->assign("userIDs", $userIDs);
	$smarty->assign("userNames", $userNames);
	$smarty->assign("userValues", $userValues);

	$smarty->display("templates/featureEdit.tpl");
?>
