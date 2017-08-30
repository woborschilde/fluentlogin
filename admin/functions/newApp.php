<?php
    require("/var/www/unscramblephp/Unscramble.php");

    $appName = $_GET["appName"];

    db_conn();
    db_switch("fluentlogin", __FILE__, __LINE__);

	db_san($_GET);

	// Check admin login status
	require("checkLogin.php");
	
    db_sel("appName", "fl_apps", "appName='$appName'", __FILE__, __LINE__);
    if ($query->num_rows > 0) {
        die("Eine Anwendung mit diesem Namen existiert bereits!");
    }

    db_ins("fl_apps", "appName", "'$appName'", __FILE__, __LINE__);

    echo "1";
?>