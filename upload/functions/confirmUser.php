<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
    require_once(__DIR__ . "/../lib/unsphp/Unscramble.php");

	$appID = $_GET["appID"];
    $userID = $_GET["userID"];
    $confirmationCode = $_GET["confirmationCode"];
    
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);
	
    db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

    if ($num_rows == 0) {
        die("An app with ID $appID does not exist!");
    }

    db_sel("NULL", "fl_apps_users", "appID='$appID' && userID='$userID' && confirmationCode='$confirmationCode'", __FILE__, __LINE__);

    if ($num_rows == 0 || $confirmationCode == "0") {
        die("The supplied confirmation code is wrong.");
    }
    
    db_upd("fl_apps_users", "confirmationCode='0'", "appID='$appID' && userID='$userID'", __FILE__, __LINE__);

    echo "Your account has been activated successfully.";
?>