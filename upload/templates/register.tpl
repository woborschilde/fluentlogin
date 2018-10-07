<!DOCTYPE html>
<html lang="en">

 <head>
    <meta charset="utf-8">
    {nocache}
		<title>Register - {$appName}</title>
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
			var queryString = ""; var an = ""; var un = ""; var ue = ""; var up = ""; var uc = ""; var ub = "";

			function register(ai) {
				an = document.getElementById("appName".toString()).value;
				un = document.getElementById("username".toString()).value;
				ue = document.getElementById("email".toString()).value;
				up = sha1(document.getElementById("password".toString()).value);  // "1-way" hash
				uc = sha1(document.getElementById("confirm_password".toString()).value);  // double hash
				ub = btoa(document.getElementById("password".toString()).value);      // base-64 "2-way" cipher, some plugins need to decrypt this

				var userFields = document.getElementsByName("field");
				userFields.forEach(setField);

				if (up != uc) {
					swal({
						type: "error",
						title: "Registration failed",
						text: "The entered passwords do not match."
					});
					return;
				}

				swal.showLoading();
				xmlhttp = new XMLHttpRequest();
				xmlhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
						swal.hideLoading();

						if (this.responseText == "1") {
							swal({
								type: "success",
								title: "Welcome to "+an+"!",
								text: "Please click the confirmation link we've sent you by e-mail to activate your account."
							}).then(function() {
								document.getElementById("login-fields").style.display = "none";
								document.getElementById("login-actions").style.display = "none";
								document.getElementById("login-finish").style.display = "block";
								document.getElementById("login-finish-button").style.display = "block";

								doJsServiceRegisters();
							});
						} else {
							swal({
								type: "error",
								title: "Registration failed",
								html: this.responseText
							});
						}
					}
				}
				xmlhttp.open("GET","functions/doRegister.php?appID="+ai+"&userName="+un+"&userEmail="+ue+"&userPassword="+up+queryString, true);
				xmlhttp.send();
			}

			function setField(item, index) {
				queryString += "&"+item.id+"="+item.value;
			}

			function doJsServiceRegisters() {
				{/literal}
					{foreach from=$jskeys item=k}
						{if $jsTypeNames[$k] != ""}
							{include file='../plugins/service.'|cat:$jsTypeNames[$k]|cat:'/js/'|cat:$jsActionNames[$k]|cat:'.tpl' sn=$jsServiceNames[$k]}
						{/if}
					{/foreach}
				{literal}
			}

			function readCookie(n){n+='=';for(var a=document.cookie.split(/;\s*/),i=a.length-1;i>=0;i--)if(!a[i].indexOf(n))return a[i].replace(n,'');}

		{/literal}
	{/nocache}
</script>

</head>

<body>

	<div class="navbar navbar-fixed-top">

	<div class="navbar-inner" style="background: {nocache}{$colorHeaderBackground}{/nocache} !important;">

		<div class="container">

			<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</a>

			<a class="brand" href="index.php?appID={$appID}">
				{nocache}{$appName}{/nocache}
			</a>

			<div class="nav-collapse">
				<ul class="nav pull-right">
					<li class="">
						<a href="" class="" onclick="window.history.back();">
							<i class="icon-chevron-left"></i>
							Back to previous page
						</a>
					</li>
				</ul>

			</div><!--/.nav-collapse -->

		</div> <!-- /container -->

	</div> <!-- /navbar-inner -->

</div> <!-- /navbar -->



<div class="account-container register">

	<div class="content clearfix">

		<form onsubmit="register({nocache}{$appID}{/nocache}); return false;">

			<h1>Create your account</h1>

			{nocache}
				{if $registrationEnabled == "1"}
					<div id="login-fields" class="login-fields">

						<p>Please fill in the following fields:</p>

						{nocache}
							<input type="hidden" id="appName" name="appName" value="{$appName}" />
						{/nocache}

						<div class="field">
							<label for="username">Username:</label>
							<input type="text" id="username" name="username" value="" placeholder="Choose a username..." class="login" required />
						</div> <!-- /field -->

						<div class="field">
							<label for="email">E-mail address:</label>
							<input type="email" id="email" name="email" value="" placeholder="Email" class="login" required />
						</div> <!-- /field -->

						<div class="field">
							<label for="password">Password:</label>
							<input type="password" id="password" name="password" value="" placeholder="Password" class="login" required />
						</div> <!-- /field -->

						<div class="field">
							<label for="confirm_password">Confirm Password:</label>
							<input type="password" id="confirm_password" name="confirm_password" value="" placeholder="Confirm Password" class="login" required />
						</div> <!-- /field -->

						{foreach from=$keys item=k}
							{if $fieldIDs[$k] != ""}
							<div class="field">
								<label for="field{$fieldIDs[$k]}">{$fieldNames[$k]}</label>
								<input type="text" id="field{$fieldIDs[$k]}" name="field" value="" placeholder="{$fieldNames[$k]}" class="login" required />
							</div> <!-- /field -->
							{/if}
						{/foreach}

					</div> <!-- /login-fields -->

					<div id="login-actions" class="login-actions">
						<button type="submit" class="button btn btn-primary btn-large">Register</button>
					</div> <!-- .actions -->

					<div id="login-finish" style="display: none;">
						<b>Registration complete</b><br />
						Please click the confirmation link we've sent you<br />by e-mail to activate your account, then continue.<br />
					</div> <!-- #login-finish -->

					<div id="login-finish-button" style="display: none;">
						<button type="button" class="button btn btn-primary btn-large" style="width: 100%;" onclick="location.replace('{$redirect}');">Go to Login 🠊</button>
					</div> <!-- #login-finish-button -->
				{else}
					<div class="alert alert-danger">
						Registration is currently disabled.
					</div>
				{/if}
			{/nocache}

		</form>

	</div> <!-- /content -->

</div> <!-- /account-container -->

<!-- Text Under Box -->
{nocache}
	<div class="login-extra" style="text-align: center;">
		<a style="color: {$colorHeaderBackground} !important;" href="passwordLost.php?appID={$appID}">Lost password?</a> |
		<a style="color: {$colorHeaderBackground} !important;" href="login.php?appID={$appID}">Login</a>
	</div> <!-- /login-extra -->
{/nocache}

<hr />
<div style="color: gray; text-align: center;">
	Powered by <a href="http://www.woborschil.de/fluentlogin" target="_blank" style="color: inherit;"><b>fluentlogin</b></a>
</div>

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.js"></script>

<script src="js/signin.js"></script>

<!-- SweetAlert Plugin Js -->
<script src="js/sweetalert2.min.js"></script>

<!-- SHA-1 Plugin Js -->
<script src="js/sha1.min.js"></script>

</body>

 </html>
