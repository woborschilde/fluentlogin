<?php

	/* Account Service "DokuWiki"

    @author  woborschil.de
	@link    http://www.woborschil.de/fluentlogin
    */

    $dokucookie = "DWd6fcb57a725757b22fe830cccebe05e6";

    // Delete old session cookie

    setcookie($dokucookie, "", time() - 1, "/");
?>
