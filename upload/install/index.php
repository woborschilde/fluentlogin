<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2018 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/

	echo "<h1>Welcome to fluentlogin Setup!</h1>
	<hr />";

	$docslink = "https://intra.woborschil.net/guide/en/fluentlogin/installation#troubleshooting";

	// Check PHP version

	if (version_compare(PHP_VERSION, "5.3.0") < 0) {
		die("You need to have at least <b>PHP 5.3.0</b> installed on your server as the magic constant 'DIR' is used by fluentlogin.<br />
		The version you have currently installed is <b>" . PHP_VERSION . "</b>.<br />
		<br />
		Please install the required PHP version in order to continue with the setup.<br />
		If this fluentlogin installation is running on a shared server, search on the Internet for how to update your PHP version or ask your webhoster.<br />
		Error code: 01");
	}

	// Check smarty cache directory for write permissions

	$write_error_msg = "Please change the owner of this directory to the user your web server runs with<br />
	and make sure to set its permissions to 0755.<br />
	<br />
	For more information, search in the <a href='$docslink' target='_blank'>documentation</a> with the following error code: 02";

	$cache_dir = "lib/smarty/app/fluentlogin/cache/";
	$template_cache_dir = "lib/smarty/app/fluentlogin/templates_c/";

	if (!(is_writable(__DIR__ . "/../$cache_dir"))) {
		die("Directory <b>$cache_dir</b> is not writable!<br />" . $write_error_msg);
	}

	if (!(is_writable(__DIR__ . "/../$template_cache_dir"))) {
		die("Directory <b>$template_cache_dir</b> is not writable!<br />" . $write_error_msg);
	}

	// Check if database credentials are set

	require_once(__DIR__ . "/../lib/unsphp/Unscramble.php");
	require($db_loginpath);

	if (($db_host == "") || ($db_username == "") || ($db_password == "") || ($db_database == "")) {
		die("One of the settings stored in your config.php is not set!<br />
		Please enter your database host (commonly localhost), username and password as well as<br />
		your database name you would like to use for this fluentlogin installation into your config.php.<br />
		<br />
		If you don't have a clue what to do now, please refer to the <a href='$docslink' target='_blank'>documentation</a> with the following error code: 03");
	}

	// Check if database credentials work

	ob_start();

	db_conn();

	if (strlen(ob_get_contents()) > 0) {
		die("<hr />Looks like there is something wrong with your database credentials. Maybe you have entered a wrong password?<br />
		Error code: 04. <a href='$docslink' target='_blank'>Documentation</a>");
	}

	ob_end_flush();

	// Let the user proceed to the next step

	echo "<b>Alright!</b> Your system seems to meet the requirements for fluentlogin.<br />
	<br />
	Setup will now install the database tables.<br />
	This may take a minute.<br />
	Please click 'Next' when you are ready to proceed.<br />
	<br />
	<a href='install.php?do=1'><b>Next ></b></a>";
?>
