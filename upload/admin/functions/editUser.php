<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2018 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

    require(__DIR__ . "/../../lib/unsphp/Unscramble.php");

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

    $appID = $_GET["appID"];
    $action = "";

	if ($_GET["userID"] != "0") {
        $userID = $_GET["userID"];
        $action = "editUser";
    } else {
        $action = "addUser";
    }

    $userName = $_GET["userName"];
    $userEmail = $_GET["userEmail"];
    $userPassword = sha1($_GET["userPassword"]);

	// Check admin login status
	require("checkLogin.php");

    $emptySha1 = "10a34637ad661d98ba3344717656fcc76209c2f8";  // results when double-hashing an empty string

    // Init service providers for login to external services
    require(__DIR__ . "/../../functions/initServiceProviders.php");

    initServiceProviders($action, "true");  // read-only test to check if there are no errors with the external services

    // Continue with fluentlogin internal database

    if (isset($userID)) {
        $query = $conn->query("SELECT NULL FROM fl_apps_users WHERE appID='$appID' && NOT userID='$userID' && (userName='$userName' || userEmail='$userEmail')");

        if ($query->num_rows > 0) {
            die("A user with these credentials already exists!");
        }

        if ($userPassword != $emptySha1) {
            db_upd("fl_apps_users", "userName='$userName', userEmail='$userEmail', userPassword='$userPassword'", "userID='$userID'", __FILE__, __LINE__);
        } else {
            db_upd("fl_apps_users", "userName='$userName', userEmail='$userEmail'", "userID='$userID'", __FILE__, __LINE__);
        }

        db_del("fl_apps_user_to_groups", "userID='$userID' && appID='$appID'", __FILE__, __LINE__); // reset user to group assignments (delete)
    } else {
        if ($userPassword == $emptySha1) {
            die("A password is required.");
        }

        $query = $conn->query("SELECT NULL FROM fl_apps_users WHERE appID='$appID' && (userName='$userName' || userEmail='$userEmail')");

        if ($query->num_rows > 0) {
            die("A user with these credentials already exists!");
        }

        db_get_ai($db_database, "fl_apps_users", __FILE__, __LINE__); $userID = $ai;
        db_ins("fl_apps_users", "appID, userName, userEmail, userPassword", "'$appID', '$userName', '$userEmail', '$userPassword'", __FILE__, __LINE__);
    }

    // set field values
    foreach ($_GET as $key => $value) {
        if (strpos($key, "field") !== false) {
            $fieldID = substr($key, 5);
            db_sel("NULL", "fl_apps_fields_values", "appID='$appID' && userID='$userID' && fieldID='$fieldID'", __FILE__, __LINE__);

            if ($num_rows > 0) {
                db_upd("fl_apps_fields_values", "fieldValue='$value'", "appID='$appID' && userID='$userID' && fieldID='$fieldID'", __FILE__, __LINE__);
            } else {
                db_ins("fl_apps_fields_values", "appID, fieldID, userID, fieldValue", "'$appID', '$fieldID', '$userID', '$value'", __FILE__, __LINE__);
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

    initServiceProviders($action);  // now actually write to external services

    echo "1";
?>
