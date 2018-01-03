<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

    require(__DIR__ . "/../../lib/unsphp/Unscramble.php");

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	// Check admin login status
	require("checkLogin.php");

	db_san($_GET);

	getVariable("plugin", "die");
	getVariable("action", "die");

	// Pass GET variables to plugin's $action.php
	foreach ($_GET as $key => $value) {
        if ((strpos($key, "plugin") === false) && (strpos($key, "action") === false)) {
			${$key} = $value;
		}
	}

	// Plugin action code
	include("../../plugins/$plugin/admin/functions/$action.php");
?>
