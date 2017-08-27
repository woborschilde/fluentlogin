<?php
    require("/var/www/unscramblephp/Unscramble.php");

	$appID = $_GET["appID"];
    
	if ($_GET["userID"] != "0") {
		$userID = $_GET["userID"];
	}

    $userName = $_GET["userName"];
    $userPassword = $_GET["userPassword"];

    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);

	db_san($_GET);
	
    if (isset($userID)) {
        db_upd("fl_apps_users", "userName='$userName', userPassword='$userPassword'", "userID='$userID'", __FILE__, __LINE__);
        db_del("fl_apps_user_to_groups", "userID='$userID' && appID='$appID'", __FILE__, __LINE__); // reset user to group assignments (delete)
    } else {
        db_get_ai("fluentlogin", "fl_apps_users", __FILE__, __LINE__); $userID = $ai;
        db_ins("fl_apps_users", "appID, userName, userPassword", "'$appID', '$userName', '$userPassword'", __FILE__, __LINE__);
    }

    // set field values
    foreach ($_GET as $key => $value) {
        if (strpos($key, "field") !== false) {
            $fieldID = substr($key, 5);
            db_sel("NULL", "fl_apps_fields_values", "appID='$appID' && userID='$userID' && fieldID='$fieldID'", __FILE__, __LINE__);
            
            if ($num_rows > 0) {
                db_upd("fl_apps_fields_values", "value='$value'", "appID='$appID' && userID='$userID' && fieldID='$fieldID'", __FILE__, __LINE__);
            } else {
                db_ins("fl_apps_fields_values", "appID, fieldID, userID, value", "'$appID', '$fieldID', '$userID', '$value'", __FILE__, __LINE__);
            }
        }
    }

    // set user to group assignments (insert)
    foreach ($_GET as $key => $value) {
        if (strpos($key, "group") !== false) {
            $groupID = substr($key, 5);
            db_ins("fl_apps_user_to_groups", "appID, userID, groupID", "'$appID', '$userID', '$groupID'", __FILE__, __LINE__);
        }
    }

    echo "1";
?>