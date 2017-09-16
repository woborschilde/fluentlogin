<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
    // Load system settings
	$query = $conn->query("SELECT settingName, settingValue FROM fl_settings ORDER BY settingID ASC");
	while ($row = $query->fetch_assoc()) {
        ${$row["settingName"]} = $row["settingValue"];
	}
?>