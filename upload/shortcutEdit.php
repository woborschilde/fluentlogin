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

	if (isset($_GET["shortcutID"])) {
		$shortcutID = $_GET["shortcutID"];
		$actionName = "($shortcutID) Edit";
	} else {
		$shortcutID = 0;
		$actionName = "Add";
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

	if ($shortcutID > 0) {
		db_sel("target, text, icon, iconColor, position", "fl_apps_user_shortcuts", "appID='$appID' && userID='$userID' && shortcutID='$shortcutID'", __FILE__, __LINE__);
	} else {
		db_get_ai($db_database, "fl_apps_user_shortcuts", __FILE__, __LINE__);

		$target = "";
		$text = "";
		$icon = "link";
		$iconColor = "525252";
		$position = $ai + 1;
	}

	// Get style (colors, etc.)
	require("functions/getStyle.php");

	// Assign variables to smarty
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
	$smarty->assign("userName", $userName);

	$smarty->assign("shortcutID", $shortcutID);
	$smarty->assign("actionName", $actionName);

	$smarty->assign("shortcutTarget", $target);
	$smarty->assign("shortcutText", $text);
	$smarty->assign("shortcutIcon", $icon);
	$smarty->assign("shortcutIconColor", $iconColor);
	$smarty->assign("shortcutPosition", $position);

	$smarty->display("templates/shortcutEdit.tpl");
?>
