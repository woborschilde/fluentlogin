<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2018 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

    require(__DIR__ . "/../../lib/unsphp/Unscramble.php");

	$appID = $_GET["appID"];
    $featureID = $_GET["featureID"];

    $shortcutTarget = $_GET["shortcutTarget"];
    $shortcutText = $_GET["shortcutText"];
    $shortcutIcon = $_GET["shortcutIcon"];
    $shortcutIconColor = $_GET["shortcutIconColor"];
    $shortcutPosition = $_GET["shortcutPosition"];

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

	// Check admin login status
	require("checkLogin.php");

    // Add/edit shortcut
    if ($featureID != "0") {
        db_upd("fl_apps_features", "target='$shortcutTarget', text='$shortcutText', icon='$shortcutIcon', iconColor='$shortcutIconColor', position='$shortcutPosition'", "appID='$appID' && featureID='$featureID'", __FILE__, __LINE__);
        db_del("fl_apps_features_values", "featureID='$featureID' && appID='$appID'", __FILE__, __LINE__); // reset feature to user/group assignments (delete)
    } else {
        db_get_ai($db_database, "fl_apps_features", __FILE__, __LINE__); $featureID = $ai;
        db_ins("fl_apps_features", "appID, target, text, icon, iconColor, position", "'$appID', '$shortcutTarget', '$shortcutText', '$shortcutIcon', '$shortcutIconColor', '$shortcutPosition'", __FILE__, __LINE__);
    }

    // add group values
    foreach ($_GET as $key => $value) {
        if (strpos($key, "group") !== false) {
            $groupID = substr($key, 5);
            db_ins("fl_apps_features_values", "appID, featureID, type, recordID", "'$appID', '$featureID', 'group', '$groupID'", __FILE__, __LINE__);
        }
    }

    // add user values
    foreach ($_GET as $key => $value) {
        if (strpos($key, "user") !== false) {
            $userID = substr($key, 4);
            db_ins("fl_apps_features_values", "appID, featureID, type, recordID", "'$appID', '$featureID', 'user', '$userID'", __FILE__, __LINE__);
        }
    }

    echo "1";
?>
