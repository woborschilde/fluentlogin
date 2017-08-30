<?php
    require("/var/www/unscramblephp/Unscramble.php");

	$appID = $_GET["appID"];
    $mode = $_GET["mode"];
    $keyID = $_GET["keyID"];
    
    if (isset($_GET["userID"])) {
        $userID = $_GET["userID"];
    }

    if (isset($_GET["userName"])) {
        $userName = $_GET["userName"];
    }

    if (isset($_GET["checkID"])) {
        $checkID = $_GET["checkID"];
    }

    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);

	db_san($_GET);
	
    db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

    if ($num_rows == 0) {
        die("An app with ID $appID does not exist!");
    }

    db_sel("NULL", "fl_apikeys", "keyID='$keyID'", __FILE__, __LINE__);

    if ($num_rows == 0) {
        die("Invalid API key.");
    }

    switch ($mode) {
        case "username":
            db_sel("userName", "fl_apps_users", "appID='$appID' && userID='$userID'", __FILE__, __LINE__);
            if ($num_rows > 0) {
                echo $userName;
            } else {
                echo 0;
            }
            break;
        case "useremail":
            db_sel("userEmail", "fl_apps_users", "appID='$appID' && userID='$userID'", __FILE__, __LINE__);
            if ($num_rows > 0) {
                echo $userEmail;
            } else {
                echo 0;
            }
            break;
        case "userid":
            db_sel("userID", "fl_apps_users", "appID='$appID' && userName='$userName'", __FILE__, __LINE__);
            if ($num_rows > 0) {
                echo $userID;
            } else {
                echo 0;
            }
            break;
        case "group":
            db_sel("NULL", "fl_apps_user_to_groups", "appID='$appID' && userID='$userID' && groupID='$checkID'", __FILE__, __LINE__);
            echo $num_rows;
            break;
        case "field":
            db_sel("fieldValue", "fl_apps_fields_values", "appID='$appID' && userID='$userID' && fieldID='$checkID'", __FILE__, __LINE__);
            if ($num_rows > 0) {
                echo $fieldValue;
            } else {
                echo 0;
            }
            break;
        case "permission":
            $query = $conn->query("SELECT groupID FROM fl_apps_user_to_groups WHERE appID='$appID' && userID='$userID' ORDER BY groupID ASC");
            while ($row = $query->fetch_assoc()) {
                $groupID = $row["groupID"];

                db_sel("permValue", "fl_apps_perms_values", "appID='$appID' && groupID='$groupID' && permID='$checkID'", __FILE__, __LINE__);
                if ($num_rows > 0) {
                    if ($permValue == 1) {
                        echo 1;
                        break 2;
                    }
                }
            }
            echo 0;
            break;
    }
?>