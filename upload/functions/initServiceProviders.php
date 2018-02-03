<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

	$serviceDatabase = "";
	$serviceTablePrefix = "";
	$serviceCookiePrefix = "";

	// Init hooks function
	function initServiceProviders($action) {
		global $conn;
		global $appID;
		global $userName;  // for use in require()
		global $cleartextPassword;  // for use in require()
		global $expiryTime;
		global $serviceDatabase;
		global $serviceTablePrefix;
		global $serviceCookiePrefix;

		$query0 = $conn->query("SELECT * FROM fl_apps_services WHERE appID = '$appID'");
		while ($row0 = $query0->fetch_assoc()) {
			$serviceType = $row0["serviceType"];
			$serviceDatabase = $row0["serviceDatabase"];
			$serviceTablePrefix = $row0["serviceTablePrefix"];
			$serviceCookiePrefix = $row0["serviceCookiePrefix"];

			require(__DIR__ . "/../plugins/service.$serviceType/functions/$action.php");
		}
	}
?>
