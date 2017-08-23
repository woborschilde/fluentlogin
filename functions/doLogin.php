<?php
    require("/var/www/unscramblephp/Unscramble.php");

	$appID = $_GET["appID"];
    $userName = $_GET["userName"];
    $userPassword = $_GET["userPassword"];

    if (isset($_GET["remember"])) {
		$remember = $_GET["remember"];
	} else {
		$remember = "false";
	}
    
    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);

    db_sel("userID", "fl_apps_users", "appID='$appID' && userName COLLATE latin1_general_cs ='$userName' && userPassword COLLATE latin1_general_cs ='$userPassword'", __FILE__, __LINE__);

    if ($num_rows == 0) {
        die("Benutzername oder Kennwort sind falsch.");
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

    // delete old sessions from database
    $t = time();
    db_del("fl_apps_sessions", "expiryTime < '$t'", __FILE__, __LINE__);

    // create session code
    $sessionID = mt_rand(100000, 999999);

    if ($remember == "true") {
        $expiryTime = time() + 31536000; // 1 year
    } else {
        $expiryTime = time() + 43200; // 12 hours
    }
    
    db_ins("fl_apps_sessions", "sessionID, appID, userID, expiryTime", "'$sessionID', '$appID', '$userID', '$expiryTime'", __FILE__, __LINE__);
    setcookie("fl$appID", "$sessionID", $expiryTime, "/fluentlogin/");

    echo "1";
?>