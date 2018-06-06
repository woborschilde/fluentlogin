<?php

	/* Account Service "MyBB 1.8"

    @author  woborschil.de
	@link    http://www.woborschil.de/fluentlogin
	*/

    function mybb18_doLogin() {
        global $conn;
        global $userName;
        global $expiryTime;
        global $serviceDatabase;
        global $serviceTablePrefix;
        global $serviceCookiePrefix;

        $stp = $serviceTablePrefix;
        $scp = $serviceCookiePrefix;

        db_switch($serviceDatabase, __FILE__, __LINE__);

        $query = $conn->query("SELECT uid, loginkey FROM " . $stp . "users WHERE username = '$userName'");
        while ($row = $query->fetch_assoc()) {
            $uid = $row["uid"];
            $loginkey = $row["loginkey"];
        }

        // Delete old session cookie

        foreach ($_COOKIE as $key => $value) {
            if ($key == $scp . "sid") {
                setcookie($key, $value, time() - 1, "/", "." . $_SERVER["HTTP_HOST"]);
            }
        }

        // Set up new session

        $sid = md5(uniqid(microtime(true), true));
        $ip = inet_pton(strtolower($_SERVER['REMOTE_ADDR']));
        $time = time();
        $useragent = $_SERVER['HTTP_USER_AGENT'];

        db_ins($stp . "sessions", "sid, uid, ip, time, useragent", "'$sid', '$uid', '$ip', '$time', '$useragent'", __FILE__, __LINE__);

        setcookie($scp . "mybbuser", $uid . "_". $loginkey, $expiryTime, "/", "." . $_SERVER["HTTP_HOST"]);
        setcookie($scp . "sid", $sid, $expiryTime, "/", "." . $_SERVER["HTTP_HOST"]);

        db_switch("fluentlogin", __FILE__, __LINE__);
    }
?>
