<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
    require("../lib/unsphp/Unscramble.php");

	$appID = $_GET["appID"];
    $userName = $_GET["userName"];
    $userEmail = $_GET["userEmail"];
    
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

    // Check user login status
    $embed = 1;
	$invert = 1;  // redirect to user panel if logged in - no infinite loop
	require("checkLogin.php");

    // Load system settings
	require("../admin/functions/loadSettings.php");

    db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

    if ($num_rows == 0) {
        die("An app with ID $appID does not exist!");
    }

    db_sel("userID, userEmail", "fl_apps_users", "appID='$appID' && userName='$userName' && confirmationCode='0'", __FILE__, __LINE__);
    
    if ($num_rows == 0 || $userName == "") {
        db_sel("userID, userName", "fl_apps_users", "appID='$appID' && userEmail='$userEmail' && confirmationCode='0'", __FILE__, __LINE__);

        if ($num_rows == 0 || $userEmail == "") {
            die("Sorry, we couln't find a user registered with these credentials.");
        }
    }
    
    $loginToken = "r" . mt_rand(10000,99999);
    
    db_upd("fl_apps_users", "loginToken='$loginToken'", "appID='$appID' && userID='$userID'", __FILE__, __LINE__);

    $msg = "Hello $userName,

Somebody requested to reset your user account password for $appName.
If this was you, click this link to set a new password:
" . $systemPath . "functions/doLogin.php?appID=$appID&userID=$userID&loginToken=$loginToken


If you haven't requested a password reset, just ignore this message. Your account stays safe.


Sincerely,
The fluentlogin system
[THIS IS AN AUTO GENERATED MESSAGE, IN CASE OF QUESTIONS: support@woborschil.de]";
    
    mail($userEmail, "Password reset requested", $msg, "From: $appName <noreply@intra.woborschil.net>");

    echo "1";
?>