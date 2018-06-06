<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2018 woborschil.de

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

    if ($serviceID != "0") {
        db_upd("fl_apps_services", "serviceName='$serviceName', serviceType='$serviceType'", "appID='$appID' && serviceID='$serviceID'", __FILE__, __LINE__);
    } else {
        db_get_ai($db_database, "fl_apps_services", __FILE__, __LINE__); $serviceID = $ai;
        db_ins("fl_apps_services", "appID, serviceName, serviceType", "'$appID', '$serviceName', '$serviceType'", __FILE__, __LINE__);
    }

    // delete ununsed service type field values (values of other service types if type was changed)
    $query0 = $conn->query("SELECT valueID, stfieldID FROM fl_apps_services_values WHERE appID='$appID' && serviceID='$serviceID' ORDER BY valueID ASC");
    while ($row0 = $query0->fetch_assoc()) {
        $valueID = $row0["valueID"];
        $stfieldID = $row0["stfieldID"];

        db_sel("typeID", "fl_servicetypes_fields", "stfieldID='$stfieldID'", __FILE__, __LINE__);
        db_sel("typeName", "fl_servicetypes", "typeID='$typeID'", __FILE__, __LINE__);

        if ($typeName != $serviceType) {
            db_del("fl_apps_services_values", "valueID='$valueID'", __FILE__, __LINE__);
        }
    }

    // set service type field values
    foreach ($_GET as $key => $value) {
        if (strpos($key, "stf_") !== false) {
            $stfieldName = substr($key, 4);
            db_sel("stfieldID", "fl_servicetypes_fields", "stfieldName='$stfieldName'", __FILE__, __LINE__);
            db_sel("NULL", "fl_apps_services_values", "appID='$appID' && serviceID='$serviceID' && stfieldID='$stfieldID'", __FILE__, __LINE__);

            if ($num_rows > 0) {
                db_upd("fl_apps_services_values", "stfieldValue='$value'", "appID='$appID' && serviceID='$serviceID' && stfieldID='$stfieldID'", __FILE__, __LINE__);
            } else {
                db_ins("fl_apps_services_values", "appID, serviceID, stfieldID, stfieldValue", "'$appID', '$serviceID', '$stfieldID', '$value'", __FILE__, __LINE__);
            }
        }
    }

    echo "1";
?>
