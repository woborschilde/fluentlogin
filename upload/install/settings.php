<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
	// Include Smarty Template Engine
	require(__DIR__ . "/../lib/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;

	if (!(isset($_GET["do"]))) {
		die("Please complete setup in the intended order. Start with index.php.");
	}

	// Establish database connection
	require_once(__DIR__ . "/../lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

	// Allow run only once

	db_sel("null", "fl_settings", "1", __FILE__, __LINE__);
	
	if ($num_rows > 0) {
		die("Your installation is already configured.");
	}

	if ($_SERVER["HTTPS"]) {
		$protocol = "https://";
	} else {
		$protocol = "http://";
	}

	// str_replace cuts out the installation path
	$systemPath = $protocol . $_SERVER["SERVER_NAME"] . str_replace("install/settings.php", "", $_SERVER["PHP_SELF"]);

	// Assign variables to smarty
	$smarty->assign("systemPath", $systemPath);

	$smarty->display("templates/settings.tpl");
?>