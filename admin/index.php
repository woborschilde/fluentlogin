<?php
	// Include Smarty Template Engine
	require("/usr/local/installed/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;
	
	// Establish database connection
	require("/var/www/unscramblephp/Unscramble.php");
    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);

	// Check admin login status
	require("functions/checkLogin.php");
	
	// Assign variables to smarty
	$smarty->assign("adminName", $adminName);

	$smarty->display("templates/index.tpl");
?>