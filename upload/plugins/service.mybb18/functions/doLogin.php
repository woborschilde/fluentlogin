<?php

	/* My best plugin!

    @author  Max Mustermann
	@link    http://www.woborschil.de/fluentlogin
	*/

    // Uncomment the following line if you want to force the "appID" argument in GET Query String (for app-related plugins):
    global $serviceDatabase;
    global $serviceTablePrefix;
    global $userName;
    global $expiryTime;

    $stp = $serviceTablePrefix;

    // Write your action logic code here...
    db_switch($serviceDatabase, __FILE__, __LINE__);

    //db_sel("uid", $stp . "users", "username = '$userName'", __FILE__, __LINE__);

    $query = $conn->query("SELECT uid, loginkey FROM mybb_users WHERE username = '$userName'");
    while ($row = $query->fetch_assoc()) {
        $uid = $row["uid"];
        $loginkey = $row["loginkey"];
    }

    $sid = md5(uniqid(microtime(true), true));
    $ip = inet_pton(strtolower($_SERVER['REMOTE_ADDR']));
    $time = time();
    $useragent = $_SERVER['HTTP_USER_AGENT'];

    db_ins($stp . "sessions", "sid, uid, ip, time, useragent", "'$sid', '$uid', '$ip', '$time', '$useragent'", __FILE__, __LINE__);

    setcookie("forum_mybbuser", $uid . "_". $loginkey, $expiryTime, "/forum/");
    setcookie("forum_sid", $sid, $expiryTime, "/forum/");

    db_switch("fluentlogin", __FILE__, __LINE__);
?>
