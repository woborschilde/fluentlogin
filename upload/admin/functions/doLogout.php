<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

    require(__DIR__ . "/../../lib/unsphp/Unscramble.php");

    if (isset($_COOKIE["fla"])) {
		$sessionID = $_COOKIE["fla"];
	} else {
		die("You can't log out because you aren't logged in!");
	}

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

    // Load system settings
	require("loadSettings.php");

    // delete current session from database
    db_del("fl_admins_sessions", "sessionID='$sessionID'", __FILE__, __LINE__);

    // delete session cookie
    $expiryTime = time() - 1; // 1 second ago
    setcookie("fla", $sessionID, $expiryTime, "/");
    //setcookie("fla", $sessionID, $expiryTime, "/" . basename(__DIR__) . "/");

    header("Location: " . $systemPath . "admin/index.php");
    die();
?>
