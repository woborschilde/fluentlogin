<?php
    require("../../lib/unsphp/Unscramble.php");

    $userID = $_GET["userID"];

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

	// Check admin login status
	require("checkLogin.php");
	
    db_del("fl_apps_users", "userID='$userID'", __FILE__, __LINE__);
    db_del("fl_apps_user_to_groups", "userID='$userID'", __FILE__, __LINE__);
?>