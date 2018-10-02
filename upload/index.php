<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2018 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

	// Include Smarty Template Engine
	require("lib/smarty/app/fluentlogin/smartyInclude.php");
	$smarty = new Smarty_FluentLogin;

	if (isset($_GET["appID"])) {
		$appID = $_GET["appID"];
	} else {
		header("Location: appChoose.php");
		die();
	}

	// Establish database connection
	require("lib/unsphp/Unscramble.php");
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

	// Check user login status
	$embed = 1;
	require("functions/checkLogin.php");

	db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

	if ($num_rows == 0) {
		die("An app with ID $appID does not exist!");
	}

	$key = 0;

	// Get shortcuts of user
	$query = $conn->query("SELECT * FROM fl_apps_user_shortcuts WHERE appID='$appID' && userID='$userID' ORDER BY position ASC");
	while ($row = $query->fetch_assoc()) {
		$shortcutTarget = $row["target"];
		$shortcutText = $row["text"];
		$shortcutIcon = $row["icon"];
		$shortcutIconColor = $row["iconColor"];

		$keys[] = $key; $key++;
		$shortcutTargets[] = $shortcutTarget;
		$shortcutTexts[] = $shortcutText;
		$shortcutIcons[] = $shortcutIcon;
		$shortcutIconColors[] = $shortcutIconColor;
	}

	if ($query->num_rows > 0) {
		$smarty->assign("shortcutTexts", $shortcutTexts);
		$smarty->assign("shortcutIcons", $shortcutIcons);
		$smarty->assign("shortcutIconColors", $shortcutIconColors);
	} else {
		$keys[] = $key;
		$shortcutTargets[] = "-";
	}

	$key1 = 0;
	$key2 = 0;

	// Get common features
	$query = $conn->query("SELECT * FROM fl_apps_features WHERE appID='$appID' ORDER BY position ASC");
	while ($row = $query->fetch_assoc()) {
		$featureID = $row["featureID"];
		$featureTarget = $row["target"];
		$featureText = $row["text"];
		$featureIcon = $row["icon"];
		$featureIconColor = $row["iconColor"];

		$personalFeature = false;

		// Get user groups
		$query1 = $conn->query("SELECT groupID FROM fl_apps_user_to_groups WHERE appID='$appID' && userID='$userID'");
		while ($row1 = $query1->fetch_assoc()) {
			$groupID = $row1["groupID"];

			// Check if it's a personal feature (by group)
			$query2 = $conn->query("SELECT NULL FROM fl_apps_features_values WHERE appID='$appID' && featureID='$featureID' && `type`='group' && recordID='$groupID'");
			while ($row2 = $query2->fetch_assoc()) {
				$keys1[] = $key1; $key1++;
				$personalTargets[] = $featureTarget;
				$personalTexts[] = $featureText;
				$personalIcons[] = $featureIcon;
				$personalIconColors[] = $featureIconColor;

				$personalFeature = true;
			}
		}

		if ($personalFeature == false) {
			// Check if it's a personal feature (by user)
			$query1 = $conn->query("SELECT NULL FROM fl_apps_features_values WHERE appID='$appID' && featureID='$featureID' && `type`='user' && recordID='$userID'");
			while ($row1 = $query1->fetch_assoc()) {
				$keys1[] = $key1; $key1++;
				$personalTargets[] = $featureTarget;
				$personalTexts[] = $featureText;
				$personalIcons[] = $featureIcon;
				$personalIconColors[] = $featureIconColor;

				$personalFeature = true;
			}
		}

		if ($personalFeature == false) {
			// Check if it's a common feature
			$query1 = $conn->query("SELECT NULL FROM fl_apps_features_values WHERE appID='$appID' && featureID='$featureID'");
			while ($row1 = $query1->fetch_assoc()) {
				// empty line is intended here
			}

			if ($query1->num_rows == 0) {
				$keys2[] = $key2; $key2++;
				$commonTargets[] = $featureTarget;
				$commonTexts[] = $featureText;
				$commonIcons[] = $featureIcon;
				$commonIconColors[] = $featureIconColor;
			}
		}
	}

	// Assign personal features to smarty
	if ($key1 > 0) {
		$smarty->assign("personalTexts", $personalTexts);
		$smarty->assign("personalIcons", $personalIcons);
		$smarty->assign("personalIconColors", $personalIconColors);
	} else {
		$keys1[] = $key1;
		$personalTargets[] = "-";
	}

	// Assign common features to smarty
	if ($key2 > 0) {
		$smarty->assign("commonTexts", $commonTexts);
		$smarty->assign("commonIcons", $commonIcons);
		$smarty->assign("commonIconColors", $commonIconColors);
	} else {
		$keys2[] = $key2;
		$commonTargets[] = "-";
	}

	// Get style (colors, etc.)
	require("functions/getStyle.php");

	// Assign variables to smarty
	$smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);

	$smarty->assign("userID", $userID);
	$smarty->assign("userName", $userName);

	$smarty->assign("keys", $keys);
	$smarty->assign("shortcutTargets", $shortcutTargets);

	$smarty->assign("keys1", $keys1);
	$smarty->assign("personalTargets", $personalTargets);

	$smarty->assign("keys2", $keys2);
	$smarty->assign("commonTargets", $commonTargets);

	$smarty->display("templates/index.tpl");
?>
