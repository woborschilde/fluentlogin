<?php
    require("../lib/unsphp/Unscramble.php");

    foreach ($_GET as $key => $value) {
        if ((strpos($value, "'") !== false) || (strpos($value, '"') !== false)) {
            die("You are not allowed to use apostrophes or quotation marks in your credentials.");
        }
    }

	$appID = $_GET["appID"];

    if (!(isset($_GET["nohash"]))) {
        $userPassword = sha1($_GET["userPassword"]);
        $newPassword = sha1($_GET["newPassword"]);
    } else {
        $userPassword = sha1(sha1($_GET["userPassword"]));
        $newPassword = sha1(sha1($_GET["newPassword"]));
    }
    
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

    // Check user login status
	$embed = 1;
	$redirect = "settings.php";
	require("checkLogin.php");

    db_sel("userPassword", "fl_apps_users", "appID='$appID' && userID='$userID' && userPassword COLLATE latin1_general_cs ='$userPassword'", __FILE__, __LINE__);

    if ($num_rows == 0) {
        die("Entered current password is wrong.");
    }
    
    if ($newPassword != "") {
        db_upd("fl_apps_users", "userPassword='$newPassword'", "appID='$appID' && userID='$userID'", __FILE__, __LINE__);
    }

    echo "1";
?>