<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2018 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

    require_once(__DIR__ . "/../lib/unsphp/Unscramble.php");

	$appID = $_GET["appID"];

    $shortcutID = $_GET["shortcutID"];
    $shortcutTarget = $_GET["shortcutTarget"];
    $shortcutText = $_GET["shortcutText"];
    $shortcutIcon = $_GET["shortcutIcon"];
    $shortcutIconColor = $_GET["shortcutIconColor"];
    $shortcutPosition = $_GET["shortcutPosition"];

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

    // Move positions
    $query = $conn->query("SELECT shortcutID, position FROM fl_apps_user_shortcuts WHERE position>='$shortcutPosition' ORDER BY position DESC");
    while ($row = $query->fetch_assoc()) {
        $sid = $row["shortcutID"];
        $pos = $row["position"] + 1;

        db_upd("fl_apps_user_shortcuts", "position='$pos'", "shortcutID='$sid'", __FILE__, __LINE__);
    }

    // Add/edit shortcut
    if ($shortcutID != "0") {
        db_upd("fl_apps_user_shortcuts", "target='$shortcutTarget', text='$shortcutText', icon='$shortcutIcon', iconColor='$shortcutIconColor', position='$shortcutPosition'", "appID='$appID' && userID='$userID' && shortcutID='$shortcutID'", __FILE__, __LINE__);
    } else {
        db_ins("fl_apps_user_shortcuts", "appID, userID, target, text, icon, iconColor, position", "'$appID', '$userID', '$shortcutTarget', '$shortcutText', '$shortcutIcon', '$shortcutIconColor', '$shortcutPosition'", __FILE__, __LINE__);
    }

    echo "1";
?>
