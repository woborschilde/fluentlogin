<?php
    require("../../lib/unsphp/Unscramble.php");

    db_conn();
    db_switch($db_database, __FILE__, __LINE__);

	db_san($_GET);

	// Check admin login status
	require("checkLogin.php");

    // set app settings
    foreach ($_GET as $key => $value) {
        if (strpos($key, "setting") !== false) {
            $settingID = substr($key, 7);
            db_sel("NULL", "fl_settings", "settingID='$settingID'", __FILE__, __LINE__);
            
            if ($num_rows > 0) {
                db_upd("fl_settings", "settingValue='$value'", "settingID='$settingID'", __FILE__, __LINE__);
            } else {
                die("This settingID does not exist!");
            }
        }
    }

    echo "1";
?>