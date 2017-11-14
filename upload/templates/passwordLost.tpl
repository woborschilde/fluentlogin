<!DOCTYPE html>
<html lang="en">
  
 <head>
    <meta charset="utf-8">
    {nocache}
		<title>Lost password - {$appName}</title>
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
    function resetPassword(ai) {
			var an = document.getElementById("appName".toString()).value;
      var un = document.getElementById("username".toString()).value;
	 		var ue = document.getElementById("email".toString()).value;
			
			swal.showLoading();
      xmlhttp = new XMLHttpRequest();
      xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
					swal.hideLoading();
          if (this.responseText == "1") {
            swal({
              type: "success",
              title: "Password reset unlocked at "+an+"!",
              text: "Please click the link we've sent you by e-mail to set a new password."
						});
          } else {
            swal({
              type: "error",
              title: "Password reset not possible",
              html: this.responseText
            });
          }
        }
      }
      xmlhttp.open("GET","functions/resetPassword.php?appID="+ai+"&userName="+un+"&userEmail="+ue, true);
      xmlhttp.send();
    }
  {/literal}
</script>

</head>

<body>
	
	<div class="navbar navbar-fixed-top">
	
	<div class="navbar-inner">
		
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
		
		<form onsubmit="resetPassword({nocache}{$appID}{/nocache}); return false;">
		
			<h1>Reset password</h1>			
			
			<div class="login-fields">
				
				<p>Please enter your username <b>or</b> your e-mail you registered with. You don't need to fill in both fields. You'll get a reset link by mail.</p>
				
				{nocache}
					<input type="hidden" id="appName" name="appName" value="{$appName}" />
				{/nocache}

				<div class="field">
					<label for="username">Username:</label>
					<input type="text" id="username" name="username" value="" placeholder="Username" class="login" />
				</div> <!-- /field -->				
				
				<div class="field">
					<label for="email">E-mail address:</label>
					<input type="email" id="email" name="email" value="" placeholder="E-mail address" class="login" />
				</div> <!-- /field -->

			</div> <!-- /login-fields -->
			
			<div class="login-actions">
									
				<button tyoe="submit" class="button btn btn-danger btn-large">Reset password</button>
				
			</div> <!-- .actions -->
			
		</form>
		
	</div> <!-- /content -->
	
</div> <!-- /account-container -->

<!-- Text Under Box -->
<div class="login-extra" style="text-align: center;">
	<a href="login.php?appID={$appID}">Login</a> | <a href="license.php?appID={$appID}">Register</a>
</div> <!-- /login-extra -->
<hr />
<div style="color: gray; text-align: center;">
	Powered by <b>fluentlogin</b>
</div>

<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.js"></script>

<script src="js/signin.js"></script>

<!-- SweetAlert Plugin Js -->
<script src="js/sweetalert2.min.js"></script>

</body>

 </html>
