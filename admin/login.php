<?php
	// Include Smarty Template Engine
	require("/usr/local/installed/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;

	// Establish database connection
	require("/var/www/unscramblephp/Unscramble.php");
    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);

	// Check user login status
	$invert = 1;  // redirect to admin panel if logged in - no infinite loop
	require("functions/checkLogin.php");

	// Assign variables to smarty
	// -- nothing to see here --

	$smarty->display("templates/login.tpl");
?>