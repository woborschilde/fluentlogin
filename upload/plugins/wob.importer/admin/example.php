<?php

	/* My best plugin!

    @author  Max Mustermann
	@link    http://www.woborschil.de/fluentlogin
	*/

    // Uncomment the following line if you want to force the "appID" argument in GET Query String (for app-related plugins):
	// getVariable("appID", "die");

    // Write your pre-display logic code here...

    db_sel("name", "fl_p_importer_name", "id = '1'", __FILE__, __LINE__);

    // Predefined variables you can change:
    $smarty->assign("pageTitle", "Plugin page title");
    $smarty->assign("pageHeading", "Plugin page heading");
    $smarty->assign("pageHeadingIcon", "icon-list-alt");       // the icon shown next to the heading
    $smarty->assign("ami", "apps");                            // activeMenuItem - possible values: "dashboard", "apps", "admins", "system"

	// Assign your variables to Smarty template engine here:
    $smarty->assign("myVariable", $name);

    // Display command will be called automatically by fluentlogin's plugin.php.
?>
