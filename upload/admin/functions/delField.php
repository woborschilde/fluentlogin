<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2018 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

    require(__DIR__ . "/../../lib/unsphp/Unscramble.php");

    $fieldID = $_GET["fieldID"];

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

	// Check admin login status
	require("checkLogin.php");

    db_del("fl_apps_fields", "fieldID='$fieldID'", __FILE__, __LINE__);
    db_del("fl_apps_fields_values", "fieldID='$fieldID'", __FILE__, __LINE__);
?>
