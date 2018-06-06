<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2018 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

	// Include Smarty Template Engine
	require(__DIR__ . "/../lib/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;

	// Establish database connection
	require_once(__DIR__ . "/../lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	// Check admin login status
	require("functions/checkLogin.php");

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
		$appNames[] = "No applications created yet.";
	}

	// Assign variables to smarty
	$smarty->assign("adminName", $adminName);
	$smarty->assign("keys", $keys);
	$smarty->assign("appIDs", $appIDs);
	$smarty->assign("appNames", $appNames);

	$smarty->display("templates/apps.tpl");
?>
