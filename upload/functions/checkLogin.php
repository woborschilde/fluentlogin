<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
    if (!(isset($embed))) {
        // Establish database connection
        require("../lib/unsphp/Unscramble.php");
        db_conn();
        db_switch($db_database, __FILE__, __LINE__);

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

	db_san($_GET);
	db_san($_COOKIE);

    // Load system settings
	require(__DIR__ . "/../admin/functions/loadSettings.php");

    // Get session by cookie
    if (isset($_COOKIE["fl" . $appID])) {
        $sessionByCookie = $_COOKIE["fl" . $appID];

        $t = time();

        // Check session in database
        db_sel("userID", "fl_apps_sessions", "appID='$appID' && sessionID='$sessionByCookie' && expiryTime > '$t'", __FILE__, __LINE__);

        if ($num_rows == 0) {
            goto not_logged_in;
	    }

        db_sel("userName, loginToken, forceNewPassword", "fl_apps_users", "appID='$appID' && userID='$userID'", __FILE__, __LINE__);

        if ((strpos($loginToken, "r") !== false) || ($forceNewPassword == "1")) {
            if ((isset($_GET["noredirect"])) || (isset($invert))) {
                if (!(isset($_GET["noredirect"]))) {
                    return -1;
                } else {
                    die("-1");
                }
            } else {
                header("Location: " . $systemPath . "newPassword.php?appID=$appID&userID=$userID&redirect=$redirect");
            }
        }
    } else {
        not_logged_in:
        if (!(isset($invert)) && !(isset($_GET["invert"]))) {
            if (!(isset($_GET["noredirect"]))) {
                header("Location: " . $systemPath . "login.php?appID=$appID&redirect=$redirect");
            }
            die("0");
        } else {
            if (!(isset($_GET["noredirect"]))) {
                return 1;
            } else {
                die("1");
            }
        }
    }

    if (!(isset($invert)) && !(isset($_GET["invert"]))) {
        if (!(isset($_GET["noredirect"]))) {
            return $userID;
        } else {
            die($userID);
        }
    } else {
        if (!(isset($_GET["noredirect"]))) {
            header("Location: " . $redirect . "?appID=$appID");
        }
        die("0");
    }
?>