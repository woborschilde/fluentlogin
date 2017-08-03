<?php
    require("/var/www/unscramblephp/Unscramble.php");

	$appID = $_GET["appID"];
    
	if ($_GET["groupID"] != "0") {
		$groupID = $_GET["groupID"];
	}

    $groupName = $_GET["groupName"];
    $groupDescription = $_GET["groupDescription"];

    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);

    if (isset($groupID)) {
        db_upd("fl_apps_groups", "groupName='$groupName', groupDescription='$groupDescription'", "groupID='$groupID'", __FILE__, __LINE__);
        db_upd("fl_apps_perms_values", "value='0'", "groupID='$groupID'", __FILE__, __LINE__);  // reset permission values (to 0)
    } else {
        db_ins("fl_apps_groups", "appID, groupName, groupDescription", "'$appID', '$groupName', '$groupDescription'", __FILE__, __LINE__);
    }

    // set permission values (usually to 1)
    foreach ($_GET as $key => $value) {
        if (strpos($key, "perm") !== false) {
            $permID = substr($key, 4);
            db_sel("NULL", "fl_apps_perms_values", "permID='$permID' && groupID='$groupID'", __FILE__, __LINE__);
            
            if ($num_rows > 0) {
                db_upd("fl_apps_perms_values", "value='$value'", "permID='$permID' && groupID='$groupID'", __FILE__, __LINE__);
            } else {
                db_ins("fl_apps_perms_values", "permID, groupID, value", "'$permID', '$groupID', '$value'", __FILE__, __LINE__);
            }
        }
    }

    echo "1";
?>