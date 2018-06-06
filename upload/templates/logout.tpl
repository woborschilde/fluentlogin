<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	{nocache}
		<title>Logout - {$appName}</title>
	{/nocache}

	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">

	<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />

	<link href="css/font-awesome.css" rel="stylesheet">

	<link href="css/style.css" rel="stylesheet" type="text/css">
	<link href="css/pages/signin.css" rel="stylesheet" type="text/css">

	<!-- Sweetalert Css -->
	<link href="css/sweetalert2.css" rel="stylesheet" />

	<script>
		{nocache}
			{literal}
				function logout(ai) {
					swal.showLoading();
					xmlhttp = new XMLHttpRequest();
					xmlhttp.onreadystatechange = function() {
						if (this.readyState == 4 && this.status == 200) {
							swal.hideLoading();
							if (this.responseText == "1") {
								doJsServiceLogouts();

								swal({
									type: "success",
									title: "Logged out",
									text: "You are now logged out."
								});
								setTimeout(function(){
									{/literal}
										location.replace("login.php"+"?appID="+ai);
									{literal}
								}, 1000);
							} else {
								swal({
									type: "error",
									title: "Logout failed",
									html: this.responseText
								});
							}
						}
					}
					xmlhttp.open("GET","functions/doLogout.php?appID="+ai,true);
					xmlhttp.send();
				}

				function doJsServiceLogouts() {
					{/literal}
						{foreach from=$jskeys item=k}
							{if $jsTypeNames[$k] != ""}
								{include file='../plugins/service.'|cat:$jsTypeNames[$k]|cat:'/js/'|cat:$jsActionNames[$k]|cat:'.tpl'}
							{/if}
						{/foreach}
					{literal}
				}

				function readCookie(n){n+='=';for(var a=document.cookie.split(/;\s*/),i=a.length-1;i>=0;i--)if(!a[i].indexOf(n))return a[i].replace(n,'');}
			{/literal}
		{/nocache}
	</script>
</head>

<body onload="logout({nocache}{$appID}{/nocache}); return false;">

	<div class="navbar navbar-fixed-top">

		<div class="navbar-inner" style="background: {nocache}{$colorHeaderBackground}{/nocache} !important;">

			<div class="container">

				<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</a>

				<a class="brand" style="color: {nocache}{$colorHeaderText}{/nocache} !important;" href="index.php?appID={$appID}">
					{nocache}{$appName}{/nocache}
				</a>

				<div class="nav-collapse">
					<ul class="nav pull-right">
						<li class="">
							<a href="" class="" style="color: {nocache}{$colorHeaderText}{/nocache} !important;" onclick="window.history.back();">
								<i class="icon-chevron-left"></i>
								Back to previous page
							</a>
						</li>
					</ul>

				</div><!--/.nav-collapse -->

			</div> <!-- /container -->

		</div> <!-- /navbar-inner -->

	</div> <!-- /navbar -->


	<script src="js/jquery-1.7.2.min.js"></script>
	<script src="js/bootstrap.js"></script>

	<script src="js/signin.js"></script>

	<!-- SweetAlert Plugin Js -->
	<script src="js/sweetalert2.min.js"></script>

	<!-- SHA-1 Plugin Js -->
	<script src="js/sha1.min.js"></script>

</body>

</html>
