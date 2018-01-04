<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

	// Init hooks function
	function initHooks($page) {
		global $smarty;

		switch ($page) {
			case "apps":
			case "users":
			case "groups":
			case "fields":
			case "permissions":
				global $plugins_hook_apps_tabs;

				queryDatabase("apps");

				$smarty->assign("plugins_hook_apps_tabs", $plugins_hook_apps_tabs);

				// no break here as the single-case-specific hooks should also apply
			case "users":
				global $plugins_hook_users_titlebuttons;

				queryDatabase("users");

				$smarty->assign("plugins_hook_users_titlebuttons", $plugins_hook_users_titlebuttons);

				break;
			case "groups":
				global $plugins_hook_groups_titlebuttons;

				queryDatabase("groups");

				$smarty->assign("plugins_hook_groups_titlebuttons", $plugins_hook_groups_titlebuttons);

				break;
			case "fields":
				global $plugins_hook_fields_titlebuttons;

				queryDatabase("fields");

				$smarty->assign("plugins_hook_fields_titlebuttons", $plugins_hook_fields_titlebuttons);

				break;
			case "permissions":
				global $plugins_hook_permissions_titlebuttons;

				queryDatabase("permissions");

				$smarty->assign("plugins_hook_permissions_titlebuttons", $plugins_hook_permissions_titlebuttons);

				break;
			default:
		}
	}

	function queryDatabase($hookgroup) {
		global $conn;

		$query = $conn->query("SELECT * FROM fl_plugins_templatehooks WHERE hookName LIKE '" . $hookgroup . "_%'");
		while ($row = $query->fetch_assoc()) {
			$pluginID = $row["pluginID"];
			$hookName = $row["hookName"];

			db_sel("pluginName", "fl_plugins", "id = '$pluginID'", __FILE__, __LINE__);
			global $pluginName;

			global ${"plugins_hook_" . $hookName};
			${"plugins_hook_" . $hookName}[] = $pluginName;
		}
	}
?>
