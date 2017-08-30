<?php
    require("/var/www/unscramblephp/Unscramble.php");

    if (isset($_COOKIE["fla"])) {
		$sessionID = $_COOKIE["fla"];
	} else {
		die("You can't log out because you aren't logged in!");
	}

    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);

	db_san($_GET);
	
    // delete current session from database
    db_del("fl_admins_sessions", "sessionID='$sessionID'", __FILE__, __LINE__);

    // delete session cookie
    $expiryTime = time() - 1; // 1 second ago
    setcookie("fla", "$sessionID", $expiryTime, "/fluentlogin/");

    header("Location: https://intra.woborschil.net/fluentlogin/admin/index.php");
    die();
?>