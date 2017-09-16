<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
    require("../lib/unsphp/Unscramble.php");

	$appID = $_GET["appID"];
    
    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);
	
    db_sel("NULL", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

    if ($num_rows == 0) {
        die("An app with ID $appID does not exist!");
    }

    echo "1";
?>