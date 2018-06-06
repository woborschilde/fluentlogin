<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2018 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

    require(__DIR__ . "/../../lib/unsphp/Unscramble.php");

	if ($_GET["appID"] != "0") {
		$appID = $_GET["appID"];
	}

    $appName = $_GET["appName"];

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

	// Check admin login status
	require("checkLogin.php");

    // get appID for new app
    if (!(isset($appID))) {
        db_get_ai($db_database, "fl_apps", __FILE__, __LINE__); $appID = $ai;
    }

    // check if appName already exists but ignore when existing app unchanged
    db_sel("NULL", "fl_apps", "appID<>'$appID' && appName='$appName'", __FILE__, __LINE__);

    if ($num_rows > 0) {
        die("An app with this name already exists!");
    }

    // update existing app / insert new app
    if (!(isset($ai))) {
        db_upd("fl_apps", "appName='$appName'", "appID='$appID'", __FILE__, __LINE__);
    } else {
        db_ins("fl_apps", "appName", "'$appName'", __FILE__, __LINE__);
    }

    // set app settings
    foreach ($_GET as $key => $value) {
        if (strpos($key, "setting") !== false) {
            $settingID = substr($key, 7);
            db_sel("NULL", "fl_appsettings_values", "appID='$appID' && settingID='$settingID'", __FILE__, __LINE__);

            if ($num_rows > 0) {
                db_upd("fl_appsettings_values", "settingValue='$value'", "appID='$appID' && settingID='$settingID'", __FILE__, __LINE__);
            } else {
                db_ins("fl_appsettings_values", "settingID, appID, settingValue", "'$settingID', '$appID', '$value'", __FILE__, __LINE__);
            }
        }
    }

    echo $appID;
?>
