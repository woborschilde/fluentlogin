<?php

	/* fluentlogin Importer Plugin

    @author  woborschil.de
	@link    http://www.woborschil.de/fluentlogin
	*/

    // Uncomment the following line if you want to force the "appID" argument in GET Query String (for app-related plugins):
    getVariable("appID", "die");

    // Write your pre-display logic code here...
    db_sel("appName", "fl_apps", "appID='$appID'", __FILE__, __LINE__);

    // Predefined variables you can change:
    $smarty->assign("appID", $appID);
	$smarty->assign("appName", $appName);
    $smarty->assign("pageTitle", "Import users");
    $smarty->assign("pageHeading", "$appName > Import users");
    $smarty->assign("pageHeadingIcon", "icon-list-alt");       // the icon shown next to the heading
    $smarty->assign("ami", "apps");                            // activeMenuItem - possible values: "dashboard", "apps", "admins", "system"

	// Assign your variables to Smarty template engine here:
    //$smarty->assign("myVariable", $name);

    // Display command will be called automatically by fluentlogin's plugin.php.
?>
