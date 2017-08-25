<?php
    require("/var/www/unscramblephp/Unscramble.php");

	$appID = $_GET["appID"];
    $userID = $_GET["userID"];
    $userPassword = $_GET["userPassword"];
    
    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);

    db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

    if ($num_rows == 0) {
        die("An app with ID $appID does not exist!");
    }

    db_sel("NULL", "fl_apps_users", "appID='$appID' && userID='$userID' && forceNewPassword='1'", __FILE__, __LINE__);

    if ($num_rows == 0) {
        die("This account is not unlocked for a password change.");
    }
    
    db_upd("fl_apps_users", "userPassword='$userPassword', loginToken='0', forceNewPassword='0'", "appID='$appID' && userID='$userID'", __FILE__, __LINE__);

    echo "1";
?>