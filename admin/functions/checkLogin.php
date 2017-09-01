<?php
	db_san($_COOKIE);

    // Load system settings
	require("loadSettings.php");

    // Get session by cookie
    if (isset($_COOKIE["fla"])) {
        $sessionByCookie = $_COOKIE["fla"];

        $t = time();

        // Check session in database
        db_sel("adminID", "fl_admins_sessions", "sessionID='$sessionByCookie' && expiryTime > '$t'", __FILE__, __LINE__);

        if ($num_rows > 0) {
            db_sel("adminName", "fl_admins", "adminID='$adminID'", __FILE__, __LINE__);
	    } else {
            goto not_logged_in;
        }
    } else {
        not_logged_in:
        if (!(isset($invert))) {
            header("Location: " . $systemPath . "admin/login.php");
            die("0");
        } else {
            return 0;
        }
    }

    if (!(isset($invert))) {
        return 1;
    } else {
        header("Location: " . $systemPath . "admin/index.php");
        die("1");
    }
?>