<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2018 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

    require(__DIR__ . "/../../lib/unsphp/Unscramble.php");

	$appID = $_GET["appID"];

	if ($_GET["groupID"] != "0") {
		$groupID = $_GET["groupID"];
	}

    $groupName = $_GET["groupName"];
    $groupDescription = $_GET["groupDescription"];

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

	// Check admin login status
	require("checkLogin.php");

    if (isset($groupID)) {
        db_upd("fl_apps_groups", "groupName='$groupName', groupDescription='$groupDescription'", "groupID='$groupID'", __FILE__, __LINE__);
        db_upd("fl_apps_perms_values", "permValue='0'", "appID='$appID' && groupID='$groupID'", __FILE__, __LINE__);  // reset permission values (to 0)
    } else {
        db_get_ai($db_database, "fl_apps_groups", __FILE__, __LINE__); $groupID = $ai;
        db_ins("fl_apps_groups", "appID, groupName, groupDescription", "'$appID', '$groupName', '$groupDescription'", __FILE__, __LINE__);
    }

    // set permission values (usually to 1)
    foreach ($_GET as $key => $value) {
        if (strpos($key, "perm") !== false) {
            $permID = substr($key, 4);
            db_sel("NULL", "fl_apps_perms_values", "appID='$appID' && permID='$permID' && groupID='$groupID'", __FILE__, __LINE__);
            if ($num_rows > 0) {
                db_upd("fl_apps_perms_values", "permValue='$value'", "appID='$appID' && permID='$permID' && groupID='$groupID'", __FILE__, __LINE__);
            } else {
                db_ins("fl_apps_perms_values", "appID, permID, groupID, permValue", "'$appID', '$permID', '$groupID', '$value'", __FILE__, __LINE__);
            }
        }
    }

    echo "1";
?>
