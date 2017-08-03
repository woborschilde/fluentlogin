<?php
	// Include Smarty Template Engine
	require("/usr/local/installed/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;
	
	// Check user login status
	//include("functions/checkLogin.php");
	
	// Load Sidenav
	//include("functions/loadSidenav.php");
	
	// Establish database connection
	//require("/var/www/unscramblephp/Unscramble.php");
    //db_conn();
    //db_switch("fluentlogin", __FILE__, __LINE__);
	
	// Assign variables to smarty
	//$smarty->assign('balanceformatted', $balanceformatted);
	
	$smarty->display('index.tpl');
?>