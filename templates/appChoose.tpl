<!DOCTYPE html>
<html lang="en">
  
<head>
    <meta charset="utf-8">
    {nocache}
			<title>fluentlogin App Chooser</title>
		{/nocache}

	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <meta name="apple-mobile-web-app-capable" content="yes"> 
    
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />

<link href="css/font-awesome.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet">
    
<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="css/pages/signin.css" rel="stylesheet" type="text/css">

<!-- Sweetalert Css -->
<link href="css/sweetalert2.css" rel="stylesheet" />

<script>
  {literal}
    function chooseApp() {
			swal({
				title: "You landed on the main page",
				text: "Enter the application ID you want to go to:",
				input: "text",
				allowOutsideClick: false,
				allowEscapeKey: false,
				showLoaderOnConfirm: true,
				inputValidator: function(value) {
					return new Promise(function (resolve, reject) {
						xmlhttp = new XMLHttpRequest();
						xmlhttp.onreadystatechange = function() {
							if (this.readyState == 4 && this.status == 200) {
								if (this.responseText == "1") {
									location.replace("index.php?appID="+value);
								} else {
									reject(this.responseText);
								}
							}
						}
						xmlhttp.open("GET","functions/chooseApp.php?appID="+value,true);
						xmlhttp.send();
					});
				},
			});
    }
  {/literal}
</script>

</head>

<body onload="chooseApp();">
	
<div class="navbar navbar-fixed-top">
	
	<div class="navbar-inner">
		
		<div class="container" style="text-align: center;">
			
			<span class="brand" style="width: 100%;">
				fluentlogin
			</span>
	
		</div> <!-- /container -->
		
	</div> <!-- /navbar-inner -->
	
</div> <!-- /navbar -->

<noscript>
	<div style="text-align: center;">
		<br />
		<b>JavaScript</b> is required to view this page.
	</div>
</noscript>

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.js"></script>

<script src="js/signin.js"></script>

<!-- SweetAlert Plugin Js -->
<script src="js/sweetalert2.min.js"></script>

<!-- SHA-1 Plugin Js -->
<script src="js/sha1.min.js"></script>

</body>

</html>
