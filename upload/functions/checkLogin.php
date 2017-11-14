<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
    if (!(isset($embed))) {
        // Establish database connection
        require_once(__DIR__ . "/../lib/unsphp/Unscramble.php");
        db_conn();
        db_switch($db_database, __FILE__, __LINE__);
    }
    
	db_san($_GET);
	db_san($_COOKIE, "fl");

    // Load system settings
	require_once(__DIR__ . "/../admin/functions/loadSettings.php");

    getVariable("appID", "die");
    getVariable("redirect", "index.php");
    getVariable("noredirect", false);
    getVariable("invert", false);
    getVariable("print", false);
    
    db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

    if ($num_rows == 0) {
        die("An app with ID $appID does not exist!");
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

        db_sel("userName, loginToken, forceNewPassword", "fl_apps_users", "appID='$appID' && userID='$userID'", __FILE__, __LINE__);

        if ((strpos($loginToken, "r") !== false) || ($forceNewPassword == "1")) {
            if ($noredirect) {
                setResult(-1);
            } else {
                header("Location: " . $systemPath . "newPassword.php?appID=$appID&userID=$userID&noredirect=1&redirect=$redirect");
            }
        } else {
            if ($noredirect) {
                setResult($userID);
            } else {
                if ($invert) {
                    header("Location: " . $redirect . "?appID=$appID");
                } else {
                    setResult($userID);
                }
            }
        }
    } else {
        not_logged_in:
        
        if ($noredirect) {
            setResult(0);
        } else {
            if ($invert) {
                setResult(0);
            } else {
                header("Location: " . $systemPath . "login.php?appID=$appID&redirect=$redirect");
            }
        }
    }

    function setResult($result) {
        global $print;
        
        if ($print) { echo $result; }
        return $result;
    }
?>