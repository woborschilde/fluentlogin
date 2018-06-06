<?php

	/* Account Service "Seafile"

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

    //db_ins("fl_plugins", "pluginName", "'service.dokuwiki'", __FILE__, __LINE__);
    //db_ins("fl_servicetypes", "typeName, typeFullName", "'dokuwiki', 'DokuWiki'", __FILE__, __LINE__);
    //db_sel("typeID", "fl_servicetypes", "typeName='dokuwiki'", __FILE__, __LINE__);
    //db_ins("fl_servicetypes_fields", "typeID, stfieldName, stfieldLabel", "'$typeID', 'serviceCookieHash', 'Cookie hash (name of a DokuWiki login cookie starting with \"DW\")'", __FILE__, __LINE__);
    //db_ins("fl_servicetypes_fields", "typeID, stfieldName, stfieldLabel", "'$typeID', 'serviceCookieSecret', 'Cookie secret (look in data/meta/_htcookiesalt2)'", __FILE__, __LINE__);

    echo "1";
?>
