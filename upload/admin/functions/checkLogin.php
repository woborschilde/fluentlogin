<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
	db_san($_COOKIE, "fl");

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
        db_sel("adminPassword", "fl_admins", "adminID='1'", __FILE__, __LINE__);
        
        /* if (!(isset($invert)) && ($sos == "")) {
            header("Location: " . $systemPath . "admin/login.php");
            die("0");
        } else {
            if ($adminPassword == "" && ($sos == "")) {
                header("Location: " . $systemPath . "admin/adminEdit.php?adminID=1&sos=1");
                die("2");
            } else if ($adminPassword == "" && ($sos != "")) {
                $adminID = 1; $adminName = "SOS";
            }
            return 0;
        } */

        if (!(isset($invert)) && ($adminPassword != "")) {
            header("Location: " . $systemPath . "admin/login.php");
            die("0");
        } else if ($adminPassword == "") {
            if ($sos == "") {  // normal admin page
                header("Location: " . $systemPath . "admin/adminEdit.php?adminID=1&sos=1");
                die("2");
            } else if ($sos != "") {  // adminEdit.php - prevents endless redirect loop
                $adminID = 1; $adminName = "SOS"; $sosok = 1;
            }
            return 0;
        } else if (isset($invert)) {
            return 1;
        }
    }
    
    // if user is logged in (above-metioned else case always ends before this point)
    if (!(isset($invert))) {
        return 1;
    } else {
        header("Location: " . $systemPath . "admin/index.php");
        die("1");
    }
?>