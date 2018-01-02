<?php

	/* My best plugin!

    @author  Max Mustermann
	@link    http://www.woborschil.de/fluentlogin
	*/
    
    // Uncomment the following line if you want to force the "appID" argument in GET Query String (for app-related plugins):
	// getVariable("appID", "die");
    
    // Write your pre-display logic code here...

	// Assign your variables to Smarty template engine here:
    $smarty->assign("myVariable", "John");
    
    // Display command will be called automatically by fluentlogin's plugin.php.
?>