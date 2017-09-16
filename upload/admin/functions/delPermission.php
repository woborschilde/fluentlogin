<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
    require("../../lib/unsphp/Unscramble.php");

    $permissionID = $_GET["permissionID"];

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

	// Check admin login status
	require("checkLogin.php");
	
    db_del("fl_apps_permissions", "permID='$permissionID'", __FILE__, __LINE__);
    db_del("fl_apps_perms_values", "permID='$permissionID'", __FILE__, __LINE__);
?>