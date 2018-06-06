<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2018 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

    // Load system settings
	$query = $conn->query("SELECT settingName, settingValue FROM fl_settings ORDER BY settingID ASC");
	while ($row = $query->fetch_assoc()) {
        ${$row["settingName"]} = $row["settingValue"];
	}

	// Variable Getter Function (from predefined var on require() or by GET Query String)
	function getVariable($key, $default) {
		global ${$key};

        if (isset(${$key})) {
            // do nothing, everything okay (from PHP require call)
        } else if (isset($_GET[$key])) {
			${$key} = $_GET[$key];  // (URL call)
        } else {
			if ($default != "die") {
				${$key} = $default;  // nothing passed
			} else {
				die("Argument ''$key'' is required!");
			}
        }
	}
?>
