<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

    require(__DIR__ . "/../../lib/unsphp/Unscramble.php");

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

    // Check admin login status
	require("checkLogin.php");

	db_san($_GET);

    getVariable("typeName", "die");

    db_sel("id", "fl_servicetypes", "typeName='$typeName'", __FILE__, __LINE__);

	$query = $conn->query("SELECT fieldName, fieldLabel FROM fl_servicetypes_fields WHERE typeID='$id' ORDER BY id ASC");
	while ($row = $query->fetch_assoc()) {
		$fieldName = $row["fieldName"];
		$fieldLabel = $row["fieldLabel"];

        echo "<div class='control-group'>
        <label class='control-label' for='$fieldName'>$fieldLabel:</label>
        <div class='controls'>
            <input type='text' class='span6' id='fieldName' value='to be filled by oem' required>
        </div>
      </div>";
	}

?>
