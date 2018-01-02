<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
	// Init hooks function
	function initHooks($page) {
		global $conn;

		switch ($page) {
			case "users":
				global $plugins_hook_users_titlebuttons;

				$query = $conn->query("SELECT * FROM fl_plugins_templatehooks WHERE hookName LIKE 'users_%'");
				while ($row = $query->fetch_assoc()) {
					$pluginID = $row["pluginID"];
					$hookName = $row["hookName"];

					db_sel("pluginName", "fl_plugins", "id = '$pluginID'", __FILE__, __LINE__);
					global $pluginName;

					${"plugins_hook_" . $hookName}[] = $pluginName;
				}

				break;
			default:
		}
	}
?>