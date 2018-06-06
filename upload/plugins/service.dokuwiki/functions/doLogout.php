<?php

	/* Account Service "DokuWiki"

    @author  woborschil.de
	@link    http://www.woborschil.de/fluentlogin
    */

    function dokuwiki_doLogout() {
        global $serviceCookieHash;

        $dokucookie = $serviceCookieHash;

        // Delete old session cookie

        setcookie($dokucookie, "", time() - 1, "/");
    }
?>
