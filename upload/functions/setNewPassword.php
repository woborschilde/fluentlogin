<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2018 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

    require_once(__DIR__ . "/../lib/unsphp/Unscramble.php");

	$appID = $_GET["appID"];
    $userID = $_GET["userID"];
    $userPassword = sha1($_GET["userPassword"]);

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

    db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

    if ($num_rows == 0) {
        die("An app with ID $appID does not exist!");
    }

    db_sel("NULL", "fl_apps_users", "appID='$appID' && userID='$userID' && forceNewPassword='1'", __FILE__, __LINE__);

    if ($num_rows == 0) {
        die("This account is not unlocked for a password change.");
    }

    db_sel("NULL", "fl_apps_users", "appID='$appID' && userID='$userID' && userPassword='$userPassword'", __FILE__, __LINE__);

    if ($num_rows > 0) {
        die("Please choose a new password.");
    }

    db_upd("fl_apps_users", "userPassword='$userPassword', loginToken='0', forceNewPassword='0'", "appID='$appID' && userID='$userID'", __FILE__, __LINE__);

    echo "1";
?>
