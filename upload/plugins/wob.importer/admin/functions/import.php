<?php

	/* My best plugin!

    @author  Max Mustermann
	@link    http://www.woborschil.de/fluentlogin
	*/

    // Uncomment the following line if you want to force the "appID" argument in GET Query String (for app-related plugins):
    getVariable("appID", "die");
    getVariable("database", "die");
    getVariable("table", "die");
    getVariable("usernameColumn", "die");
    getVariable("emailColumn", "");
    getVariable("regdateColumn", "");

    // Write your action logic code here...

    $count = 0;

    $query0 = $conn->query("SELECT * FROM $database.$table");
    while ($row0 = $query0->fetch_assoc()) {
        $username = $row0["$usernameColumn"];

        if ($emailColumn != "") { $email = $row0["$emailColumn"]; } else { $email = mt_rand(100000, 999999); }   // e-mail address must be unique, replacement
        if ($regdateColumn != "") { $regdate = $row0["$regdateColumn"]; } else { $regdate = ""; }

        db_sel("NULL", "fl_apps_users", "appID = '$appID' && username = '$username'", __FILE__, __LINE__);
        if ($num_rows == 0) {
            db_ins("fl_apps_users", "appID, username, userEmail, registrationDate", "'$appID', '$username', '$email', '$regdate'", __FILE__, __LINE__);
            $count++;
        }
    }

    echo $count;
?>
