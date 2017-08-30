<?php
	// Include Smarty Template Engine
	require("/usr/local/installed/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;
	
	// Establish database connection
	require("/var/www/unscramblephp/Unscramble.php");
    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);

	// Check admin login status
	require("functions/checkLogin.php");
	
	$key = 0;
	
	// Get admins of app
	$query = $conn->query("SELECT * FROM fl_admins ORDER BY adminID ASC");
	while ($row = $query->fetch_assoc()) {
		$adminID = $row["adminID"];
		$adminNameField = $row["adminName"];

		$keys[] = $key; $key++;
		$adminIDs[] = $adminID;
		$adminNames[] = $adminName;
	}

	if ($query->num_rows == 0) {
		$keys[] = $key;
		$adminIDs[] = "-";
		$adminNames[] = "No admins created yet.";
	}

	// Assign variables to smarty
	$smarty->assign("adminName", $adminName);  // from checkLogin
	$smarty->assign("keys", $keys);
	$smarty->assign("adminIDs", $adminIDs);
	$smarty->assign("adminNames", $adminNames);
	
	$smarty->display("templates/admins.tpl");
?>