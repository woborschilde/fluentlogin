<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
    require("../lib/unsphp/Unscramble.php");

    foreach ($_GET as $key => $value) {
        if ((strpos($value, "'") !== false) || (strpos($value, '"') !== false)) {
            die("You are not allowed to use apostrophes or quotation marks in your credentials.");
        }
    }

	$appID = $_GET["appID"];
    $userName = $_GET["userName"];
    $userEmail = $_GET["userEmail"];
    
    if (!(isset($_GET["nohash"]))) {
        $userPassword = sha1($_GET["userPassword"]);
    } else {
        $userPassword = sha1(sha1($_GET["userPassword"]));
    }
    
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

    // get if registration is enabled for this app
	db_sel("settingID", "fl_appsettings", "settingName='registration'", __FILE__, __LINE__);
	db_sel("NULL", "fl_appsettings_values", "appID='$appID' && settingID='$settingID' && settingValue='on'", __FILE__, __LINE__);

	if ($num_rows == 0) {
		die("Registration is currently disabled.");
	}
	//

    db_sel("NULL", "fl_apps_users", "appID='$appID' && (userName='$userName' || userEmail='$userEmail')", __FILE__, __LINE__);

    if ($num_rows > 0) {
        die("An account with this username or this e-mail address already exists.");
    }

    db_get_ai($db_database, "fl_apps_users", __FILE__, __LINE__); $userID = $ai;

    // set field values
    foreach ($_GET as $key => $value) {
        if (strpos($key, "field") !== false) {
            $fieldID = substr($key, 5);
            db_ins("fl_apps_fields_values", "appID, fieldID, userID, fieldValue", "'$appID', '$fieldID', '$userID', '$value'", __FILE__, __LINE__);
        }
    }
    
    $registrationDate = time();
    $confirmationCode = mt_rand(100000,999999);

    db_ins("fl_apps_users", "appID, userName, userEmail, userPassword, registrationDate, confirmationCode", "'$appID', '$userName', '$userEmail', '$userPassword', '$registrationDate', '$confirmationCode'", __FILE__, __LINE__);

    $msg = "Hello $userName,
A user account has just been registered for $appName with this e-mail address ($userEmail).
It has to be activated by clicking on the following link:
" . $systemPath . "functions/confirmUser.php?appID=$appID&userID=$userID&confirmationCode=$confirmationCode


If you haven't registered an account, just ignore this message.


Sincerely,
The fluentlogin system
[THIS IS AN AUTO GENERATED MESSAGE, IN CASE OF QUESTIONS: support@woborschil.de]";
    
    mail($userEmail, "E-mail confirmation", $msg, "From: $appName <noreply@intra.woborschil.net>");

    echo "1";
?>