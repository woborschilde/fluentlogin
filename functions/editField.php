<?php
    require("/var/www/unscramblephp/Unscramble.php");

	$appID = $_GET["appID"];
    
	if ($_GET["fieldID"] != "0") {
		$fieldID = $_GET["fieldID"];
	}

    $fieldName = $_GET["fieldName"];
    $fieldDescription = $_GET["fieldDescription"];

    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);

    if (isset($fieldID)) {
        db_upd("fl_apps_fields", "fieldName='$fieldName', fieldDescription='$fieldDescription'", "fieldID='$fieldID'", __FILE__, __LINE__);
    } else {
        db_ins("fl_apps_fields", "appID, fieldName, fieldDescription", "'$appID', '$fieldName', '$fieldDescription'", __FILE__, __LINE__);
    }

    echo "1";
?>