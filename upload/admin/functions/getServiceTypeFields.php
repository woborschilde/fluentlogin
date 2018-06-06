<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2018 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

    require(__DIR__ . "/../../lib/unsphp/Unscramble.php");

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

    // Check admin login status
	require("checkLogin.php");

	db_san($_GET);

    getVariable("appID", "die");
    getVariable("serviceID", "die");
    getVariable("typeName", "die");

    db_sel("typeID", "fl_servicetypes", "typeName='$typeName'", __FILE__, __LINE__);

	$query0 = $conn->query("SELECT stfieldID, stfieldName, stfieldLabel FROM fl_servicetypes_fields WHERE typeID='$typeID' ORDER BY stfieldID ASC");
	while ($row0 = $query0->fetch_assoc()) {
        $stfieldID = $row0["stfieldID"];
		$stfieldName = $row0["stfieldName"];
		$stfieldLabel = $row0["stfieldLabel"];

        unset($stfieldValue);
        db_sel("stfieldValue", "fl_apps_services_values", "appID='$appID' && serviceID='$serviceID' && stfieldID='$stfieldID'", __FILE__, __LINE__);
        if (!(isset($stfieldValue))) { $stfieldValue = ""; }

        echo "<div class='control-group'>
        <label class='control-label' for='$stfieldName'>$stfieldLabel:</label>
        <div class='controls'>
            <input type='text' class='span6' name='stfield' id='$stfieldName' value='$stfieldValue'>
        </div>
      </div>";
	}
?>
