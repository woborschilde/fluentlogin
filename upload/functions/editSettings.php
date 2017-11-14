<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
    require_once(__DIR__ . "/../lib/unsphp/Unscramble.php");

    $appID = $_GET["appID"];
    $userEmail = $_GET["userEmail"];

    if (!(isset($_GET["nohash"]))) {
        $userPassword = sha1($_GET["userPassword"]);
        $newPassword = sha1($_GET["newPassword"]);
    } else {
        $userPassword = sha1(sha1($_GET["userPassword"]));
        $newPassword = sha1(sha1($_GET["newPassword"]));
    }
    
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);
	
    // Check user login status
	$embed = 1;
	$redirect = "settings.php";
	require("checkLogin.php");

    db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

    if ($num_rows == 0) {
        die("An app with ID $appID does not exist!");
    }

    db_upd("fl_apps_users", "userEmail='$userEmail'", "appID='$appID' && userID='$userID'", __FILE__, __LINE__);

    $emptySha1 = "10a34637ad661d98ba3344717656fcc76209c2f8";
    if ($userPassword != $emptySha1) {
        db_sel("userPassword", "fl_apps_users", "appID='$appID' && userID='$userID' && userPassword COLLATE latin1_general_cs ='$userPassword'", __FILE__, __LINE__);

        if ($num_rows == 0) {
            die("Entered current password is wrong.");
        }
        
        if ($newPassword == $emptySha1) {
            die("You can't remove your password.");
        }

        db_upd("fl_apps_users", "userPassword='$newPassword'", "appID='$appID' && userID='$userID'", __FILE__, __LINE__);
    }

    echo "1";
?>