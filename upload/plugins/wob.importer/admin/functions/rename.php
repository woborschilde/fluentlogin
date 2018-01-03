<?php

	/* My best plugin!

    @author  Max Mustermann
	@link    http://www.woborschil.de/fluentlogin
	*/

    // Uncomment the following line if you want to force the "appID" argument in GET Query String (for app-related plugins):
	// getVariable("appID", "die");

    // Write your action logic code here...

    db_upd("fl_p_importer_name", "name = '$name'", "id = '1'", __FILE__, __LINE__);

    echo "1";
?>
