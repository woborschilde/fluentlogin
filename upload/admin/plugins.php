<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2018 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

	// Include Smarty Template Engine
	require(__DIR__ . "/../lib/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;

	// Establish database connection
	require_once(__DIR__ . "/../lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	// Check admin login status
	require("functions/checkLogin.php");

	$key = 0;

	// Check available plugins
	$plugins = scandir(__DIR__ . "/../plugins");

    foreach ($plugins as $value) {
		if ($value != "." && $value != "..") {
			db_sel("pluginID", "fl_plugins", "pluginName='$value'", __FILE__, __LINE__);

			$keys[] = $key; $key++;
			$pluginNames[] = $value;

			if (strpos($value, "service.") !== false) {
				$pluginTypes[] = "service";
			} else {
				$pluginTypes[] = "normal";
			}

			if ($num_rows > 0) {
				$pluginStatus[] = "1";  // installed
			} else {
				$pluginStatus[] = "0";  // not installed
			}
		}
	}

	if (count($plugins) == 2) {  // only "." for current, and ".." for parent directory --> empty plugin directory
		$keys[] = $key;
		$pluginNames[] = "No plugins available.";
		$pluginTypes[] = "";
		$pluginStatus[] = "";
	}

	// Assign variables to smarty
	$smarty->assign("adminID", $adminID);  // from checkLogin
	$smarty->assign("adminName", $adminName);  // from checkLogin
	$smarty->assign("keys", $keys);
	$smarty->assign("pluginNames", $pluginNames);
	$smarty->assign("pluginTypes", $pluginTypes);
	$smarty->assign("pluginStatus", $pluginStatus);

	$smarty->display("templates/plugins.tpl");
?>
