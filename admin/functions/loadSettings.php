<?php
    // Load system settings
	$query = $conn->query("SELECT settingName, settingValue FROM fl_settings ORDER BY settingID ASC");
	while ($row = $query->fetch_assoc()) {
        ${$row["settingName"]} = $row["settingValue"];
	}
?>