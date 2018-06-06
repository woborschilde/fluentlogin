<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	{nocache}
		<title>Login - {$appName}</title>
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
				var queryString = ""; var un = ""; var up = ""; var ub = ""; var ue = "";

				function login(ai) {
					un = document.getElementById("username".toString()).value;
					up = sha1(document.getElementById("password".toString()).value);  // "1-way" hash
					ub = btoa(document.getElementById("password".toString()).value);  // base-64 "2-way" cipher, some plugins need to decrypt this

					var userFields = document.getElementsByName("field");
					userFields.forEach(setField);

					var re = document.getElementById("remember".toString()).checked;

					swal.showLoading();
					xmlhttp = new XMLHttpRequest();
					xmlhttp.onreadystatechange = function() {
						if (this.readyState == 4 && this.status == 200) {
							swal.hideLoading();
							if (this.responseText.includes("@")) {
								ue = this.responseText;  // needed for some services which use email for auth instead of username
								doJsServiceLogins();

								swal({
									type: "success",
									title: "Logged in",
									text: "You are now logged in."
								});
								setTimeout(function(){
									{/literal}
										location.replace("{$redirect}"+"?appID="+ai);
									{literal}
								}, 1000);
							} else {
								swal({
									type: "error",
									title: "Login failed",
									html: this.responseText
								});
							}
						}
					}
					xmlhttp.open("GET","functions/doLogin.php?appID="+ai+"&userName="+un+"&userPassword="+up+queryString+"&remember="+re+"&b64="+ub,true);
					xmlhttp.send();
				}

				function setField(item, index) {
					queryString += "&"+item.id+"="+item.value;
				}

				function doJsServiceLogins() {
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

<body>

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

<div class="account-container">

	<div class="content clearfix">

		<form onsubmit="login({nocache}{$appID}{/nocache}); return false;">

			<h1>Log in to {nocache}{$appName}{/nocache}</h1>

			<div class="login-fields">

				<p>Please log in to continue.</p>

				<div class="field">
					<label for="username">Username</label>
					<input type="text" id="username" name="username" value="" placeholder="Username" class="login username-field" tabindex="1" />
				</div> <!-- /field -->

				<div class="field">
					<label for="password">Password</label>
					<input type="password" id="password" name="password" value="" placeholder="Password" class="login password-field" tabindex="2" />
				</div> <!-- /password -->

				{nocache}
				  {counter start=2 print=false}   <!-- https://www.smarty.net/docsv2/en/language.function.counter -->
				  {foreach from=$keys item=k}
					  {if $fieldIDs[$k] != ""}
						<div class="field">
							<label for="field{$fieldIDs[$k]}">{$fieldNames[$k]}</label>
							<input type="text" id="field{$fieldIDs[$k]}" name="field" value="" placeholder="{$fieldNames[$k]}" class="login username-field" tabindex="{counter}" required />
						</div> <!-- /field -->
					  {/if}
				  {/foreach}
				{/nocache}

			</div> <!-- /login-fields -->

			<div class="alert alert-info">
				By logging in, you accept cookies to be saved on your computer.
			</div>

			<div class="login-actions">

				<span class="login-checkbox">
					<input id="remember" name="remember" type="checkbox" class="field login-checkbox" value="First Choice" tabindex="{nocache}{counter}{/nocache}" />
					<label class="choice" for="remember">Stay logged in</label>
				</span>

				<button type="submit" class="button btn btn-success btn-large" tabindex="{nocache}{counter}{/nocache}">Log in</button>

			</div> <!-- .actions -->

		</form>

	</div> <!-- /content -->

</div> <!-- /account-container -->

{nocache}
	<div class="login-extra" style="text-align: center;">
		<a style="color: {$colorHeaderBackground} !important;" href="passwordLost.php?appID={$appID}">Lost password?</a> |
		<a style="color: {$colorHeaderBackground} !important;" href="license.php?appID={$appID}">Register</a>
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
