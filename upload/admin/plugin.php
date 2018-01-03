<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

	// Include Smarty Template Engine
	require(__DIR__ . "/../lib/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;

	/*
	if (isset($_GET["appID"])) {
		$appID = $_GET["appID"];
	} else {
		die("Argument ''appID'' is required!");
	}
	*/

	// Establish database connection
	require_once(__DIR__ . "/../lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	// Check admin login status
	require("functions/checkLogin.php");

	db_san($_GET);

	getVariable("plugin", "die");
	getVariable("page", "die");

	//db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

	// Plugin code
	include("../plugins/$plugin/admin/$page.php");

	// Assign variables to smarty
	//$smarty->assign("appID", $appID);
	//$smarty->assign("appName", $appName);
	$smarty->assign("adminName", $adminName);
	$smarty->assign("pluginName", $plugin);
	$smarty->assign("pageName", $page);

	//$smarty->assign("plugins_hook_users_titlebuttons", $plugins_hook_users_titlebuttons);

	//$smarty->display("../plugins/$plugin/admin/templates/$page.tpl");
	$smarty->display("templates/plugin.tpl");
?>
