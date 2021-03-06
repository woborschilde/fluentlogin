<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

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
	
	// Get admins of app
	$query = $conn->query("SELECT * FROM fl_admins ORDER BY adminID ASC");
	while ($row = $query->fetch_assoc()) {
		$adminIDField = $row["adminID"];
		$adminNameField = $row["adminName"];

		$keys[] = $key; $key++;
		$adminIDs[] = $adminIDField;
		$adminNames[] = $adminNameField;
	}

	if ($query->num_rows == 0) {
		$keys[] = $key;
		$adminIDs[] = "-";
		$adminNames[] = "No admins created yet.";
	}

	// Assign variables to smarty
	$smarty->assign("adminID", $adminID);  // from checkLogin
	$smarty->assign("adminName", $adminName);  // from checkLogin
	$smarty->assign("keys", $keys);
	$smarty->assign("adminIDs", $adminIDs);
	$smarty->assign("adminNames", $adminNames);
	
	$smarty->display("templates/admins.tpl");
?>