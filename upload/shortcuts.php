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

	// Establish database connection
	require("lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

	// Check user login status
	$embed = 1;
	$redirect = "shortcuts.php";
	require("functions/checkLogin.php");

	db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

	$key = 0;

	// Get shortcuts of user
	$query = $conn->query("SELECT * FROM fl_apps_user_shortcuts WHERE appID='$appID' && userID='$userID' ORDER BY position ASC");
	while ($row = $query->fetch_assoc()) {
		$shortcutID = $row["shortcutID"];
		$shortcutText = $row["text"];
		$shortcutIcon = $row["icon"];
		$shortcutIconColor = $row["iconColor"];

		$keys[] = $key; $key++;
		$shortcutIDs[] = $shortcutID;
		$shortcutTexts[] = $shortcutText;
		$shortcutIcons[] = $shortcutIcon;
		$shortcutIconColors[] = $shortcutIconColor;
	}

	if ($query->num_rows == 0) {
		$keys[] = $key;
		$shortcutIDs[] = "-";
		$shortcutTexts[] = "No shortcuts created yet.";
		$shortcutIcons[] = "";
		$shortcutIconColors[] = "";
	}

	// Get style (colors, etc.)
	require("functions/getStyle.php");

	// Assign variables to smarty
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
	$smarty->assign("userID", $userID);
	$smarty->assign("userName", $userName);

	$smarty->assign("keys", $keys);
	$smarty->assign("shortcutIDs", $shortcutIDs);
	$smarty->assign("shortcutTexts", $shortcutTexts);
	$smarty->assign("shortcutIcons", $shortcutIcons);
	$smarty->assign("shortcutIconColors", $shortcutIconColors);

	$smarty->display("templates/shortcuts.tpl");
?>
