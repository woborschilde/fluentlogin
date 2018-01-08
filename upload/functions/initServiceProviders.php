<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

	$serviceDatabase = "";
	$serviceTablePrefix = "";

	// Init hooks function
	function initServiceProviders($action) {
		global $conn;
		global $appID;
		global $userName;  // for use in require()
		global $expiryTime;
		global $serviceDatabase;
		global $serviceTablePrefix;

		$query = $conn->query("SELECT * FROM fl_apps_services WHERE appID = '$appID'");
		while ($row = $query->fetch_assoc()) {
			$serviceType = $row["serviceType"];
			$serviceDatabase = $row["serviceDatabase"];
			$serviceTablePrefix = $row["serviceTablePrefix"];

			require(__DIR__ . "/../plugins/service.$serviceType/functions/$action.php");
		}
	}
?>
