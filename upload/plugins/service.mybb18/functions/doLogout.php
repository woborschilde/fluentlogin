<?php

	/* Account Service "MyBB 1.8"

    @author  woborschil.de
	@link    http://www.woborschil.de/fluentlogin
    */

    global $serviceCookiePrefix;

    $scp = $serviceCookiePrefix;

    // Delete old session cookies

    foreach ($_COOKIE as $key => $value) {
        if ($key == $scp . "sid" || $key == $scp . "mybbuser") {
            setcookie($key, $value, time() - 1, "/", "." . $_SERVER["HTTP_HOST"]);
        }
    }
?>
