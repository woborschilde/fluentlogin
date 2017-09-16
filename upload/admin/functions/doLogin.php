<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
    require("../../lib/unsphp/Unscramble.php");

    $adminName = $_GET["adminName"];
    $adminPasswordField = sha1($_GET["adminPassword"]);

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

    db_san($_GET);

    // Check admin login status
	$invert = 1;  // redirect to admin panel if logged in - no infinite loop
	require("checkLogin.php");
    
    db_sel("adminID", "fl_admins", "adminName COLLATE latin1_general_cs ='$adminName' && adminPassword COLLATE latin1_general_cs ='$adminPasswordField'", __FILE__, __LINE__);

    if ($num_rows == 0) {
        die("Username or password are wrong.");
    }

    // delete old sessions from database
    $t = time();
    db_del("fl_apps_sessions", "expiryTime < '$t'", __FILE__, __LINE__);

    // create session code
    $sessionID = mt_rand(100000, 999999);

    $expiryCookie = 0; // until the end of session
    $expiryTime = time() + 43200; // 12 hours

    
    db_ins("fl_admins_sessions", "sessionID, adminID, expiryTime", "'$sessionID', '$adminID', '$expiryTime'", __FILE__, __LINE__);
    setcookie("fla", $sessionID, $expiryCookie, "/");

    echo "1";
?>