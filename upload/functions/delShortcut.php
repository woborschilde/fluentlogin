<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2018 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

    require_once(__DIR__ . "/../lib/unsphp/Unscramble.php");

    $shortcutID = $_GET["shortcutID"];

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

	// Check user login status
	$embed = 1;
	$redirect = "settings.php";
	require("checkLogin.php");

    db_del("fl_apps_user_shortcuts", "shortcutID='$shortcutID' && userID='$userID' && appID='$appID'", __FILE__, __LINE__);
?>
