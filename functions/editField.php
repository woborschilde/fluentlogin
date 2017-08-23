<?php
    require("/var/www/unscramblephp/Unscramble.php");

	$appID = $_GET["appID"];
    
	if ($_GET["fieldID"] != "0") {
		$fieldID = $_GET["fieldID"];
	}

    $fieldName = $_GET["fieldName"];
    $fieldDescription = $_GET["fieldDescription"];
    $showOnLogin = $_GET["showOnLogin"];

    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);

    if (isset($fieldID)) {
        db_upd("fl_apps_fields", "fieldName='$fieldName', fieldDescription='$fieldDescription', showOnLogin='$showOnLogin'", "appID='$appID' && fieldID='$fieldID'", __FILE__, __LINE__);
    } else {
        db_ins("fl_apps_fields", "appID, fieldName, fieldDescription, showOnLogin", "'$appID', '$fieldName', '$fieldDescription', '$showOnLogin'", __FILE__, __LINE__);
    }

    echo "1";
?>