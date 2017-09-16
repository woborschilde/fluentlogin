<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
	// Include Smarty Template Engine
	require("../lib/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;
	
	// Establish database connection
	require("../lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	// Check admin login status
	require("functions/checkLogin.php");
	
	// Assign variables to smarty
	$smarty->assign("adminName", $adminName);

	$smarty->display("templates/index.tpl");
?>