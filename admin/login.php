<?php
	// Include Smarty Template Engine
	require("../lib/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;

	// Establish database connection
	require("../lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	// Check admin login status
	$invert = 1;  // redirect to admin panel if logged in - no infinite loop
	require("functions/checkLogin.php");

	// Assign variables to smarty
	// -- nothing to see here --

	$smarty->display("templates/login.tpl");
?>