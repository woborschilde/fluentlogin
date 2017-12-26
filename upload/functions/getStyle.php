<?php

	/* fluentlogin User Management System
	Licensed under GNU GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

	Copyright (C) 2017 woborschil.de

	@link    http://www.woborschil.de/fluentlogin
	*/
	
    // Get colors
	db_sel("settingValue", "fl_appsettings_values", "settingID='3' && appID='$appID'", __FILE__, __LINE__);

	if ($num_rows > 0) {
		$colorHeaderBackground = $settingValue;
	} else {
		db_sel("settingDefault", "fl_appsettings", "settingID='3'", __FILE__, __LINE__);
		$colorHeaderBackground = $settingDefault;
	}
	
	db_sel("settingValue", "fl_appsettings_values", "settingID='4' && appID='$appID'", __FILE__, __LINE__);
	
	if ($num_rows > 0) {
		$colorHeaderText = $settingValue;
	} else {
		db_sel("settingDefault", "fl_appsettings", "settingID='4'", __FILE__, __LINE__);
		$colorHeaderText = $settingDefault;
	}

	$smarty->assign("colorHeaderBackground", $colorHeaderBackground);
	$smarty->assign("colorHeaderText", $colorHeaderText);
?>