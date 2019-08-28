<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2018 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

    require(__DIR__ . "/../../lib/unsphp/Unscramble.php");

    $adminToDeleteID = $_GET["adminToDeleteID"];  // different name because of checkLogin

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

	// Check admin login status
	require("checkLogin.php");

    db_del("fl_admins", "adminID='$adminToDeleteID'", __FILE__, __LINE__);
    db_del("fl_admins_sessions", "adminID='$adminToDeleteID'", __FILE__, __LINE__);
?>
