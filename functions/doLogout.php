<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
    require("../lib/unsphp/Unscramble.php");

    if ((isset($_GET["appID"])) && (isset($_GET["userID"]))) {
		$appID = $_GET["appID"];
        $userID = $_GET["userID"];
	} else {
		die("Argument ''appID'' and ''userID'' are required!");
	}

    if (isset($_COOKIE["fl" . $appID])) {
		$sessionID = $_COOKIE["fl" . $appID];
	} else {
		die("You can't log out because you aren't logged in!");
	}

    if (isset($_GET["redirect"])) {
        $redirect = $_GET["redirect"];
    } else {
        $redirect = "index.php";
    }

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);
	
    // Load system settings
	require("../admin/functions/loadSettings.php");

    // delete current session from database
    db_del("fl_apps_sessions", "sessionID='$sessionID'", __FILE__, __LINE__);

    // delete session cookie
    $expiryTime = time() - 1; // 1 second ago
    setcookie("fl$appID", $sessionID, $expiryTime, "/");

    header("Location: " . $systemPath . "$redirect?appID=$appID");
    die();
?>