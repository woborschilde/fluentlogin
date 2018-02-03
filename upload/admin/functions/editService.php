<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

    require(__DIR__ . "/../../lib/unsphp/Unscramble.php");

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

	// Check admin login status
	require("checkLogin.php");

    getVariable("appID", "die");
    getVariable("serviceID", "die");
    getVariable("serviceName", "die");
    getVariable("serviceType", "die");
    getVariable("serviceDatabase", "die");
    getVariable("serviceTablePrefix", "die");
    getVariable("serviceCookiePrefix", "die");

    if ($serviceID != "0") {
        db_upd("fl_apps_services", "serviceName='$serviceName', serviceType='$serviceType', serviceDatabase='$serviceDatabase', serviceTablePrefix='$serviceTablePrefix', serviceCookiePrefix='$serviceCookiePrefix'", "appID='$appID' && id='$serviceID'", __FILE__, __LINE__);
    } else {
        db_ins("fl_apps_services", "appID, serviceName, serviceType, serviceDatabase, serviceTablePrefix, serviceCookiePrefix", "'$appID', '$serviceName', '$serviceType', '$serviceDatabase', '$serviceTablePrefix', '$serviceCookiePrefix'", __FILE__, __LINE__);
    }

    echo "1";
?>
