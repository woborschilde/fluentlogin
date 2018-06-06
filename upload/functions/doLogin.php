<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

    require_once(__DIR__ . "/../lib/unsphp/Unscramble.php");

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

    db_san($_GET);

    // Check user login status
    $embed = 1;
	$invert = 1;  // redirect to user panel if logged in - no infinite loop
	require("checkLogin.php");

    if (!(isset($_GET["loginToken"]))) {
        getVariable("userName", "die");

        if (!(isset($_GET["nohash"]))) {
            $userPassword = sha1($_GET["userPassword"]);
        } else {
            $userPassword = sha1(sha1($_GET["userPassword"]));
        }

        if (isset($_GET["b64"])) {
            $cleartextPassword = base64_decode($_GET["b64"]);  // for plugin use
        } else {
            $cleartextPassword = "";
        }
    } else {
        getVariable("userID", "die");
        getVariable("loginToken", "die");
    }

    getVariable("remember", false);
    getVariable("noredirect", false);

    if (!(isset($_GET["loginToken"]))) {
        db_sel("userID, userEmail", "fl_apps_users", "appID='$appID' && userName COLLATE latin1_general_cs = '$userName' && userPassword COLLATE latin1_general_cs = '$userPassword'", __FILE__, __LINE__);

        if ($num_rows == 0) {
            die("2: Username or password are wrong.");
        }

        db_sel("NULL", "fl_apps_users", "appID='$appID' && userName='$userName' && confirmationCode>'0'", __FILE__, __LINE__);

        if ($num_rows > 0) {
            die("3: This account has not been activated yet.");
        }
    } else {
        db_sel("NULL", "fl_apps_users", "appID='$appID' && userID='$userID' && loginToken='$loginToken'", __FILE__, __LINE__);

        if ($num_rows == 0) {
            die("4: This token is invalid.");
        }

        if (strpos($loginToken, "r") !== false) {
            db_upd("fl_apps_users", "forceNewPassword='1'", "appID='$appID' && userID='$userID'", __FILE__, __LINE__);

            if (!($noredirect)) {
                header("Location: " . $systemPath . "newPassword.php?appID=$appID&userID=$userID&redirect=index.php");
                die();
            } else {
                die("5: Your current password has expired. In order to continue, you have to set a new one.");
            }
        }
    }

    // check field values
    foreach ($_GET as $key => $value) {
        if (strpos($key, "field") !== false) {
            $fieldID = substr($key, 5);
            db_sel("fieldName", "fl_apps_fields", "appID='$appID' && fieldID='$fieldID'", __FILE__, __LINE__);
            db_sel("NULL", "fl_apps_fields_values", "appID='$appID' && userID='$userID' && fieldID='$fieldID' && fieldValue COLLATE latin1_general_cs = '$value'", __FILE__, __LINE__);

            if ($num_rows == 0) {
                die("6: '$fieldName' does not match with this account.");
            }
        }
    }

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

    // Init service providers for login to external services
    require("initServiceProviders.php");
    initServiceProviders("doLogin");

    db_ins("fl_apps_sessions", "sessionID, appID, userID, expiryTime", "'$sessionID', '$appID', '$userID', '$expiryTime'", __FILE__, __LINE__);
    setcookie("fl$appID", $sessionID, $expiryTime, "/");
    //setcookie("fl$appID", $sessionID, $expiryTime, "/" . basename(__DIR__) . "/");

    echo $userEmail;
?>
