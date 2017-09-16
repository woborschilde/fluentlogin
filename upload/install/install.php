<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
	echo "<h1>fluentlogin Setup</h1>
	<hr />";

	if (!(isset($_GET["do"]))) {
		die("Please complete setup in the intended order. Start with index.php.");
	}

	$docslink = "https://intra.woborschil.net/docs/en/fluentlogin/configuration#troubleshooting";

	// Install database tables

	require("../lib/unsphp/Unscramble.php");
	db_conn();
	
	$query = $conn->query("CREATE DATABASE IF NOT EXISTS $db_database");
	if ($conn->error) {
		die("Something went wrong on database creation (Please refer to <a href='$docslink' target='_blank'>documentation</a> with error code 05):<br />" . $conn->error);
	}

	db_switch($db_database, __FILE__, __LINE__);

	if (db_table_exists($db_database, "fl_admins", __FILE__, __LINE__) == 1) {
		die("fluentlogin is already installed.");
	}

	db_create_table("fl_admins", "adminID int(11) UNSIGNED NOT NULL AUTO_INCREMENT, adminName varchar(255) NOT NULL, adminPassword varchar(255) NOT NULL, PRIMARY KEY (adminID)", __FILE__, __LINE__);
	db_create_table("fl_admins_sessions", "sessionID int(11) UNSIGNED NOT NULL AUTO_INCREMENT, adminID int(11) UNSIGNED NOT NULL, expiryTime int(11) UNSIGNED NOT NULL, PRIMARY KEY (sessionID)", __FILE__, __LINE__);
	db_create_table("fl_apikeys", "keyID int(11) UNSIGNED NOT NULL, PRIMARY KEY (keyID)", __FILE__, __LINE__);
	db_create_table("fl_apps", "appID int(11) UNSIGNED NOT NULL AUTO_INCREMENT, appName varchar(255) UNIQUE NOT NULL, adminPassword varchar(255) NOT NULL, PRIMARY KEY (appID)", __FILE__, __LINE__);
	db_create_table("fl_appsettings", "settingID int(11) UNSIGNED NOT NULL AUTO_INCREMENT, settingName varchar(255) UNIQUE NOT NULL, settingDefault varchar(255) NOT NULL, PRIMARY KEY (settingID)", __FILE__, __LINE__);
	db_create_table("fl_appsettings_values", "valueID int(11) UNSIGNED NOT NULL AUTO_INCREMENT, settingID int(11) UNSIGNED NOT NULL, appID int(11) UNSIGNED NOT NULL, settingValue varchar(255) NOT NULL, PRIMARY KEY (valueID)", __FILE__, __LINE__);
	db_create_table("fl_apps_fields", "fieldID int(11) UNSIGNED NOT NULL AUTO_INCREMENT, appID int(11) UNSIGNED NOT NULL, fieldName varchar(255) NOT NULL, fieldDescription varchar(255) NOT NULL, showOnLogin tinyint(1) NOT NULL, showOnRegister tinyint(1) NOT NULL, PRIMARY KEY (fieldID)", __FILE__, __LINE__);
	db_create_table("fl_apps_fields_values", "valueID int(11) UNSIGNED NOT NULL AUTO_INCREMENT, appID int(11) UNSIGNED NOT NULL, fieldID int(11) UNSIGNED NOT NULL, userID int(11) UNSIGNED NOT NULL, fieldValue varchar(255) NOT NULL, PRIMARY KEY (valueID)", __FILE__, __LINE__);
	db_create_table("fl_apps_groups", "groupID int(11) UNSIGNED NOT NULL AUTO_INCREMENT, appID int(11) UNSIGNED NOT NULL, groupName varchar(255) NOT NULL, groupDescription varchar(255) NOT NULL, PRIMARY KEY (groupID)", __FILE__, __LINE__);
	db_create_table("fl_apps_permissions", "permID int(11) UNSIGNED NOT NULL AUTO_INCREMENT, appID int(11) UNSIGNED NOT NULL, permName varchar(255) NOT NULL, permDescription varchar(255) NOT NULL, PRIMARY KEY (permID)", __FILE__, __LINE__);
	db_create_table("fl_apps_perms_values", "valueID int(11) UNSIGNED NOT NULL AUTO_INCREMENT, appID int(11) UNSIGNED NOT NULL, permID int(11) UNSIGNED NOT NULL, groupID int(11) UNSIGNED NOT NULL, permValue varchar(255) NOT NULL, PRIMARY KEY (valueID)", __FILE__, __LINE__);
	db_create_table("fl_apps_sessions", "sessionID int(11) UNSIGNED NOT NULL AUTO_INCREMENT, appID int(11) UNSIGNED NOT NULL, userID int(11) UNSIGNED NOT NULL, expiryTime int(11) UNSIGNED NOT NULL, PRIMARY KEY (sessionID)", __FILE__, __LINE__);
	db_create_table("fl_apps_users", "userID int(11) UNSIGNED NOT NULL AUTO_INCREMENT, appID int(11) UNSIGNED NOT NULL, userName varchar(255) NOT NULL, userEmail varchar(255) NOT NULL, userPassword varchar(255) NOT NULL, registrationDate int(11) UNSIGNED NOT NULL, confirmationCode int(11) UNSIGNED NOT NULL, loginToken varchar(255) NOT NULL, forceNewPassword tinyint(1) NOT NULL, PRIMARY KEY (userID)", __FILE__, __LINE__);
	db_create_table("fl_apps_user_to_groups", "appID int(11) UNSIGNED NOT NULL, userID int(11) UNSIGNED NOT NULL, groupID int(11) UNSIGNED NOT NULL, PRIMARY KEY (appID, userID, groupID)", __FILE__, __LINE__);
	db_create_table("fl_settings", "settingID int(11) UNSIGNED NOT NULL AUTO_INCREMENT, settingName varchar(255) UNIQUE NOT NULL, settingValue varchar(255) NOT NULL, PRIMARY KEY (settingID)", __FILE__, __LINE__);

	// Create settings

	db_ins("fl_appsettings", "settingName, settingDefault", "'license', ''", __FILE__, __LINE__);
	db_ins("fl_appsettings", "settingName, settingDefault", "'registration', 'on'", __FILE__, __LINE__);

	// Create API Key
	
	$keyID = mt_rand(10000, 99999);

	db_ins("fl_apikeys", "keyID", "'$keyID'", __FILE__, __LINE__);

	// Let the user proceed to the next step

	echo "<b>Perfect!</b> The database tables have been installed successfully.<br />
	<br />
	Setup will now ask you some questions about your system and create your fluentlogin administrator account.<br />
	Please click 'Next' when you are ready to proceed.<br />
	<br />
	<a href='settings.php?do=1'><b>Next ></b></a>";
?>