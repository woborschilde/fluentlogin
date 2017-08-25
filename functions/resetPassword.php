<?php
    require("/var/www/unscramblephp/Unscramble.php");

	$appID = $_GET["appID"];
    $userName = $_GET["userName"];
    $userEmail = $_GET["userEmail"];
    
    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);

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
    
    $loginToken = "r" . mt_rand(10000,99999);
    
    db_upd("fl_apps_users", "loginToken='$loginToken'", "appID='$appID' && userID='$userID'", __FILE__, __LINE__);

    $msg = "Hello $userName,

Somebody requested to reset your user account password for $appName.
If this was you, click this link to set a new password:
https://intra.woborschil.net/fluentlogin/functions/doLogin.php?appID=$appID&userID=$userID&loginToken=$loginToken


If you haven't requested a password reset, just ignore this message. Your account stays safe.
support@woborschil.de


Sincerely,
The fluentlogin system
[THIS IS AN AUTO GENERATED MESSAGE, IN CASE OF QUESTIONS: support@woborschil.de]";
    
    mail($userEmail, "Password reset requested", $msg, "From: $appName <noreply@intra.woborschil.net>");

    echo "1";
?>