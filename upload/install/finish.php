<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
	// Include Smarty Template Engine
	require(__DIR__ . "/../lib/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;

	if (!(isset($_POST["systemPath"]))) {
		die("Please complete setup in the intended order. Start with index.php.");
	}

	$systemPath = $_POST["systemPath"];
	$supportEmail = $_POST["supportEmail"];
	$adminName = $_POST["adminName"];
	$adminPassword = sha1(sha1($_POST["adminPassword"]));
	$confirmPassword = sha1(sha1($_POST["confirmPassword"]));

	if ($adminPassword != $confirmPassword) {
		die("<b>Whoops!</b><br />
		The entered passwords do not match. Please go back and try again.");
	}

	// Establish database connection
	require_once(__DIR__ . "/../lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_POST);

	// Allow run only once

	db_sel("null", "fl_settings", "1", __FILE__, __LINE__);
	
	if ($num_rows > 0) {
		die("Your installation is already configured.");
	}

	// Save settings

	db_ins("fl_settings", "settingName, settingValue", "'systemPath', '$systemPath'", __FILE__, __LINE__);
	db_ins("fl_settings", "settingName, settingValue", "'supportEmail', '$supportEmail'", __FILE__, __LINE__);

	db_ins("fl_admins", "adminName, adminPassword", "'$adminName', '$adminPassword'", __FILE__, __LINE__);

	// Display smarty template
	$smarty->display("templates/finish.tpl");
?>