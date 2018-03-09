<?php

	/* Account Service "MyBB 1.8"

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

    db_ins("fl_plugins", "pluginName", "'service.mybb18'", __FILE__, __LINE__);
    db_ins("fl_servicetypes", "typeName, typeFullName", "'mybb18', 'MyBB 1.8'", __FILE__, __LINE__);
    db_sel("typeID", "fl_servicetypes", "typeName='mybb18'", __FILE__, __LINE__);
    db_ins("fl_servicetypes_fields", "typeID, stfieldName, stfieldLabel", "'$typeID', 'serviceDatabase', 'Service database'", __FILE__, __LINE__);
    db_ins("fl_servicetypes_fields", "typeID, stfieldName, stfieldLabel", "'$typeID', 'serviceTablePrefix', 'Service database table prefix (if any)'", __FILE__, __LINE__);
    db_ins("fl_servicetypes_fields", "typeID, stfieldName, stfieldLabel", "'$typeID', 'serviceCookiePrefix', 'Service cookie prefix (if any)'", __FILE__, __LINE__);

    echo "1";
?>
