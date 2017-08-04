<?php
	// Include Smarty Template Engine
	require("/usr/local/installed/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;

	if (isset($_GET["appID"])) {
		$appID = $_GET["appID"];
	} else {
		die("Argument ''appID'' is required!");
	}

	if (isset($_GET["userID"])) {
		$userID = $_GET["userID"];
		$actionName = "$userID bearbeiten";
	} else {
		$userID = 0;
		$actionName = "hinzufügen";
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

	if ($userID > 0) {
		db_sel("userName, userPassword", "fl_apps_users", "userID='$userID'", __FILE__, __LINE__);
	} else {
		$userName = "";
		$userPassword = "";
	}

	$key0 = 0;
	
	// Get fields of app
	$query0 = $conn->query("SELECT fieldID, fieldName FROM fl_apps_fields WHERE appID='$appID' ORDER BY fieldName ASC");
	$num_rows0 = $query0->num_rows;
	while ($row0 = $query0->fetch_assoc()) {
		$fieldID = $row0["fieldID"];
		$fieldName = $row0["fieldName"];

		$keys0[] = $key0; $key0++;
		$fieldIDs[] = $fieldID;
		$fieldNames[] = $fieldName;

		// Get field values for user
		//db_sel("value", "fl_apps_fields_values", "fieldID='$fieldID' && userID='$userID' && appID='$appID'", __FILE__, __LINE__);
		$query1 = $conn->query("SELECT value FROM fl_apps_fields_values WHERE fieldID='$fieldID' && userID='$userID' && appID='$appID'");
		while ($row1 = $query1->fetch_assoc()) {
			$fieldValues[] = $row1["value"];
		}

		if ($query1->num_rows == 0) {
			$fieldValues[] = "";
		}
		//
	}

	if ($num_rows0 == 0) {
		$keys0[] = $key0;
		$fieldIDs[] = "-";
		$fieldNames[] = "Noch keine Felder erstellt.";
		$fieldValues[] = "";
	}

	$key = 0;

	// Get user groups of app
	$query0 = $conn->query("SELECT groupID, groupName FROM fl_apps_groups WHERE appID='$appID' ORDER BY groupName ASC");
	$num_rows0 = $query0->num_rows;
	while ($row0 = $query0->fetch_assoc()) {
		$groupID = $row0["groupID"];
		$groupName = $row0["groupName"];

		$keys[] = $key; $key++;
		$groupIDs[] = $groupID;
		$groupNames[] = $groupName;

		// Get user to groups
		db_sel("NULL", "fl_apps_user_to_groups", "groupID='$groupID' && userID='$userID' && appID='$appID'", __FILE__, __LINE__);

		if ($num_rows > 0) {
			$groupValues[] = "checked";
		} else {
			$groupValues[] = "";
		}
		//
	}
	
	if ($num_rows0 == 0) {
		$keys[] = $key;
		$groupIDs[] = "-";
		$groupNames[] = "Noch keine Benutzergruppen erstellt.";
		$groupValues[] = "";
	}

	// Assign variables to smarty
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
	$smarty->assign("userID", $userID);
	$smarty->assign("actionName", $actionName);
	$smarty->assign("userName", $userName);
	$smarty->assign("userPassword", $userPassword);

	$smarty->assign("keys0", $keys0);
	$smarty->assign("fieldIDs", $fieldIDs);
	$smarty->assign("fieldNames", $fieldNames);
	$smarty->assign("fieldValues", $fieldValues);

	$smarty->assign("keys", $keys);
	$smarty->assign("groupIDs", $groupIDs);
	$smarty->assign("groupNames", $groupNames);
	$smarty->assign("groupValues", $groupValues);
	
	$smarty->display("userEdit.tpl");
?>