<?php
    if (!(isset($embed))) {
        // Establish database connection
        require("/var/www/unscramblephp/Unscramble.php");
        db_conn();
        db_switch("fluentlogin", __FILE__, __LINE__);

        if (isset($_GET["appID"])) {
            $appID = $_GET["appID"];
        } else {
            die("Argument ''appID'' is required!");
        }

        db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

        if ($num_rows == 0) {
            die("An app with ID $appID does not exist!");
        }

        if (isset($_GET["redirect"])) {
            $redirect = $_GET["redirect"];
        } else {
            $redirect = "index.php";
        }
    }

    // Get session by cookie
    if (isset($_COOKIE["fl" . $appID])) {
        $sessionByCookie = $_COOKIE["fl" . $appID];

        $t = time();

        // Check session in database
        db_sel("userID", "fl_apps_sessions", "appID='$appID' && sessionID='$sessionByCookie' && expiryTime > '$t'", __FILE__, __LINE__);

        if ($num_rows == 0) {
            goto not_logged_in;
	    }

        db_sel("userName", "fl_apps_users", "appID='$appID' && userID='$userID'", __FILE__, __LINE__);
    } else {
        not_logged_in:
        header("Location: https://intra.woborschil.net/fluentlogin/login.php?appID=$appID&redirect=$redirect");
        die();
    }
?>