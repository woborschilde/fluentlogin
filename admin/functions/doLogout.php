<?php
    require("../../lib/unsphp/Unscramble.php");

    // Load system settings
	require("functions/loadSettings.php");

    if (isset($_COOKIE["fla"])) {
		$sessionID = $_COOKIE["fla"];
	} else {
		die("You can't log out because you aren't logged in!");
	}

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);
	
    // delete current session from database
    db_del("fl_admins_sessions", "sessionID='$sessionID'", __FILE__, __LINE__);

    // delete session cookie
    $expiryTime = time() - 1; // 1 second ago
    setcookie("fla", $sessionID, $expiryTime, "/" . basename(__DIR__) . "/");

    header("Location: " . $systemPath . "admin/index.php");
    die();
?>