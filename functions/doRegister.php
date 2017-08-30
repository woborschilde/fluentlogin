<?php
    require("/var/www/unscramblephp/Unscramble.php");

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
    db_switch("fluentlogin", __FILE__, __LINE__);

	db_san($_GET);
	
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
        die("Ein Konto mit diesem Benutzernamen oder dieser E-Mail-Adresse existiert bereits.");
    }

    // set field values
    /* foreach ($_GET as $key => $value) {
        if (strpos($key, "field") !== false) {
            $fieldID = substr($key, 5);
            db_sel("NULL", "fl_apps_fields_values", "appID='$appID' && userID='$userID' && fieldID='$fieldID'", __FILE__, __LINE__);
            
            if ($num_rows > 0) {
                db_upd("fl_apps_fields_values", "value='$value'", "appID='$appID' && userID='$userID' && fieldID='$fieldID'", __FILE__, __LINE__);
            } else {
                db_ins("fl_apps_fields_values", "appID, fieldID, userID, value", "'$appID', '$fieldID', '$userID', '$value'", __FILE__, __LINE__);
            }
        }
    }*/
    
    $confirmationCode = mt_rand(100000,999999);

    db_get_ai("fluentlogin", "fl_apps_users", __FILE__, __LINE__); $userID = $ai;
    db_ins("fl_apps_users", "appID, userName, userEmail, userPassword, confirmationCode", "'$appID', '$userName', '$userEmail', '$userPassword', '$confirmationCode'", __FILE__, __LINE__);

    $msg = "Hello $userName,
A user account has just been registered for $appName with this e-mail address ($userEmail).
It has to be activated by clicking on the following link:
https://intra.woborschil.net/fluentlogin/functions/confirmUser.php?appID=$appID&userID=$userID&confirmationCode=$confirmationCode


If you haven't registered an account, just ignore this message.


Sincerely,
The fluentlogin system
[THIS IS AN AUTO GENERATED MESSAGE, IN CASE OF QUESTIONS: support@woborschil.de]";
    
    mail($userEmail, "E-mail confirmation", $msg, "From: $appName <noreply@intra.woborschil.net>");

    echo "1";
?>