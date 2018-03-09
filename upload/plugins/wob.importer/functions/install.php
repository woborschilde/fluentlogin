<?php

	/* Account Service "DokuWiki"

    @author  woborschil.de
	@link    http://www.woborschil.de/fluentlogin
	*/

    // Establish database connection
    require_once(__DIR__ . "/../../../lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

    // Check admin login status
    require(__DIR__ . "/../../../admin/functions/checkLogin.php");

    // Install database tables  (write your code here)

    db_ins("fl_plugins", "pluginName", "'wob.importer'", __FILE__, __LINE__);
    db_sel("pluginID", "fl_plugins", "pluginName='wob.importer'", __FILE__, __LINE__);
    db_ins("fl_plugins_templatehooks", "pluginID, hookName", "'$pluginID', 'users_titlebuttons'", __FILE__, __LINE__);

    echo "1";
?>
