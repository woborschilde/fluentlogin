<?php
	// Include Smarty Template Engine
	require("../lib/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;

	// Establish database connection
	require("../lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);
	
	db_san($_GET);

	// Check admin login status
	require("functions/checkLogin.php");

	$key = 0;
	
	// Get system settings
	$query = $conn->query("SELECT settingID, settingName, settingValue FROM fl_settings ORDER BY settingID ASC");
	$num_rows = $query->num_rows;
	while ($row = $query->fetch_assoc()) {
		$settingID = $row["settingID"];
		$settingName = $row["settingName"];
		$settingValue = $row["settingValue"];

		$keys[] = $key; $key++;
		$settingIDs[] = $settingID;
		$settingNames[] = $settingName;
		$settingValues[] = $settingValue;
	}

	if ($num_rows == 0) {
		$keys[] = $key;
		$settingIDs[] = "-";
		$settingNames[] = "No settings available.";
		$settingValues[] = "";
	}

	db_sel("keyID", "fl_apikeys", "1", __FILE__, __LINE__);

	// Assign variables to smarty
	$smarty->assign("adminName", $adminName);

	$smarty->assign("keys", $keys);
	$smarty->assign("settingIDs", $settingIDs);
	$smarty->assign("settingNames", $settingNames);
	$smarty->assign("settingValues", $settingValues);

	$smarty->assign("keyID", $keyID);
	
	$smarty->display("templates/settings.tpl");
?>