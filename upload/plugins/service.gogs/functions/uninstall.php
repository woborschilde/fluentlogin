<?php

	/* Account Service "Gogs"

    @author  woborschil.de
	@link    http://www.woborschil.de/fluentlogin
	*/

    // Establish database connection
	require_once(__DIR__ . "/../../../lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	// Check admin login status
	require(__DIR__ . "/../../../admin/functions/checkLogin.php");

    // Check if service type is still in use by any service
    /*
    $servicesErrorText = "";

    $query = $conn->query("SELECT appID, serviceName FROM fl_apps_services WHERE serviceType='dokuwiki'");  // <== write here

    if ($query->num_rows > 0) {
        $servicesErrorText = "The service provider you want to uninstall is still in use by the following services:<br />";
    }

    while ($row = $query->fetch_assoc()) {
        $appID = $row["appID"];
        $serviceName = $row["serviceName"];

        $servicesErrorText .= "<br />$serviceName (App ID $appID)";
    }

    if ($query->num_rows > 0) {
        die($servicesErrorText . "<br /><br />Please make sure to change the service types of these services before you remove the service provider.");
    }

    // Uninstall database tables  (write your code here)

    db_del("fl_plugins", "pluginName='service.dokuwiki'", __FILE__, __LINE__);
    db_sel("typeID", "fl_servicetypes", "typeName='dokuwiki'", __FILE__, __LINE__);
    db_del("fl_servicetypes", "typeName='dokuwiki'", __FILE__, __LINE__);
    db_del("fl_servicetypes_fields", "typeID='$typeID'", __FILE__, __LINE__);
    */
    echo "1";
?>
