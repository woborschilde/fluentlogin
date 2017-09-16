<!DOCTYPE html>
<html lang="en">
  
<head>
    <meta charset="utf-8">
    {nocache}
			<title>Neues Passwort setzen - {$appName}</title>
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
    function setNewPassword(ai) {
			var ui = document.getElementById("userID".toString()).value;
      var up = sha1(document.getElementById("password".toString()).value);
	  	var uc = sha1(document.getElementById("confirm_password".toString()).value);

			if (up != uc) {
				swal({
					type: "error",
					title: "Can't save that",
					text: "The entered passwords do not match."
				});
				return;
			}

      xmlhttp = new XMLHttpRequest();
      xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          if (this.responseText == "1") {
            swal({
              type: "success",
              title: "Password changed",
              text: "Your password has been changed successfully."
            });
            setTimeout(function(){
              {/literal}
								location.replace("{$redirect}"+"?appID="+ai);
							{literal}
            }, 1000);
          } else {
            swal({
              type: "error",
              title: "Couldn't change password",
              html: this.responseText
            });
          }
        }
      }
      xmlhttp.open("GET","functions/setNewPassword.php?appID="+ai+"&userID="+ui+"&userPassword="+up,true);
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



<div class="account-container">
	
	<div class="content clearfix">
		
		<form onsubmit="setNewPassword({nocache}{$appID}{/nocache}); return false;">
		
			<h1>Set new password</h1>		
			
			<div class="login-fields">
				
				<p>Your current password has expired. In order to continue, you have to set a new one.</p>
				
				{nocache}
					<input type="hidden" id="userID" name="userID" value="{$userID}" />
				{/nocache}

				<div class="field">
					<label for="password">New Password:</label>
					<input type="password" id="password" name="password" value="" placeholder="New Password" class="login password-field" required />
				</div> <!-- /field -->
				
				<div class="field">
					<label for="confirm_password">Confirm New Password:</label>
					<input type="password" id="confirm_password" name="confirm_password" value="" placeholder="Confirm New Password" class="login password-field" required />
				</div> <!-- /field -->

			</div> <!-- /login-fields -->

			<div class="login-actions">
				
				<button type="submit" class="button btn btn-primary btn-large">Save</button>
				<a href="functions/doLogout.php?appID={$appID}&userID={$userID}" class="button btn btn-default btn-large" style="margin-right: 10px;">Logout</a>
				
			</div> <!-- .actions -->
			
		</form>
		
	</div> <!-- /content -->
	
</div> <!-- /account-container -->

<hr />
<div style="color: gray; text-align: center;">
	Powered by <b>fluentlogin</b>
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
