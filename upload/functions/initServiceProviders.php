<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

	$serviceID = "";

	// Init hooks function
	function initServiceProviders($action) {
		global $conn;
		global $appID;
		global $userName;  // next ones all for use in require()
		global $cleartextPassword;
		global $expiryTime;
		global $serviceID;

		$query0 = $conn->query("SELECT * FROM fl_apps_services WHERE appID='$appID'");
		while ($row0 = $query0->fetch_assoc()) {
			$serviceID = $row0["serviceID"];
			$serviceType = $row0["serviceType"];

			// create named service type field variables for use in plugin files (resulting variables have to be scoped in this context first)
			global $typeID;
			db_sel("typeID", "fl_servicetypes", "typeName='$serviceType'", __FILE__, __LINE__);

			$query2 = $conn->query("SELECT stfieldID, stfieldName FROM fl_servicetypes_fields WHERE typeID='$typeID'");
			while ($row2 = $query2->fetch_assoc()) {
				$stfieldID = $row2["stfieldID"];
				$stfieldName = $row2["stfieldName"];

				global $stfieldValue;
				db_sel("stfieldValue", "fl_apps_services_values", "appID='$appID' && serviceID='$serviceID' && stfieldID='$stfieldID'", __FILE__, __LINE__);

				// establish named service type field variable (like "serviceTablePrefix" -> "forum_")
				global ${$stfieldName};
				${$stfieldName} = $stfieldValue;
			}

			require(__DIR__ . "/../plugins/service.$serviceType/functions/$action.php");
		}
	}
?>
