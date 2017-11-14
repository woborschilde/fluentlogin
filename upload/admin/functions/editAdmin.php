<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
    require(__DIR__ . "/../../lib/unsphp/Unscramble.php");
    
	if ($_GET["adminIDField"] != "0") {
		$adminIDField = $_GET["adminIDField"];
	}

    $adminNameField = $_GET["adminNameField"];
    $adminPasswordField = sha1($_GET["adminPasswordField"]);
    
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

    // Check admin login status
    if (isset($_GET["sos"])) {
		$sos = "&sos=1";  // allow access even without login -> for admin password reset
	} else {
		$sos = "";
	}
	require("checkLogin.php");
    
    $emptySha1 = "10a34637ad661d98ba3344717656fcc76209c2f8";  // results when double-hashing an empty string
    
    if (isset($adminIDField)) {
        if ($adminPasswordField != $emptySha1) {
            db_upd("fl_admins", "adminName='$adminNameField', adminPassword='$adminPasswordField'", "adminID='$adminIDField'", __FILE__, __LINE__);
        } else {
            db_upd("fl_admins", "adminName='$adminNameField'", "adminID='$adminIDField'", __FILE__, __LINE__);
        }
        //db_del("fl_apps_admin_to_apps", "adminID='$adminID' && appID='$appID'", __FILE__, __LINE__); // reset admin to app assignments (delete)
    } else {
        if ($adminPasswordField == $emptySha1) {
            die("A password is required.");
        }
        db_ins("fl_admins", "adminName, adminPassword", "'$adminNameField', '$adminPasswordField'", __FILE__, __LINE__);
    }

    // set admin to app assignments (insert) -- for Beta 2
    /* foreach ($_GET as $key => $value) {
        if (strpos($key, "app") !== false) {
            $appID = substr($key, 5);
            db_ins("fl_apps_admin_to_apps", "appID, adminID, appID", "'$appID', '$adminID', '$appID'", __FILE__, __LINE__);
        }
    } */

    echo "1";
?>