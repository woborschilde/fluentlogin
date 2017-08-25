<!DOCTYPE html>
<html lang="en">
  
 <head>
    <meta charset="utf-8">
    {nocache}
		<title>Registrieren - {$appName}</title>
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
    var queryString = "";

    function register(ai) {
      var un = document.getElementById("username".toString()).value;
	  var ue = document.getElementById("email".toString()).value;
      var up = document.getElementById("password".toString()).value;
	  var uc = document.getElementById("confirm_password".toString()).value;
	  
	  var an = "AppName";
      
      var userFields = document.getElementsByName("field");
      userFields.forEach(setField);

	  if (up != uc) {
		swal({
			type: "error",
			title: "Registrierung fehlgeschlagen",
			text: "Die eingegebenen Kennwörter stimmen nicht überein."
		});
		return;
	  }

      xmlhttp = new XMLHttpRequest();
      xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          if (this.responseText == "1") {
            swal({
              type: "success",
              title: "Willkommen bei "+an+"!",
              text: "Bitte klicken Sie zur Kontoaktivierung auf den Bestätigungslink, den wir Ihnen per E-Mail zugesendet haben."
            }).then(function () {
			  location.replace("{$redirect}"+"?appID="+ai);
			});
          } else {
            swal({
              type: "error",
              title: "Registrierung fehlgeschlagen",
              text: this.responseText
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
			
			<a class="brand" href="index.html">
				{nocache}{$appName}{/nocache}
			</a>		
			
			<div class="nav-collapse">
				<ul class="nav pull-right">
					<li class="">						
						<a href="index.html" class="">
							<i class="icon-chevron-left"></i>
							Zurück zur vorherigen Seite
						</a>
					</li>
				</ul>
				
			</div><!--/.nav-collapse -->	
	
		</div> <!-- /container -->
		
	</div> <!-- /navbar-inner -->
	
</div> <!-- /navbar -->



<div class="account-container register">
	
	<div class="content clearfix">
		
		<form onsubmit="register({$appID}); return false;">
		
			<h1>Create your account</h1>			
			
			<div class="login-fields">
				
				<p>Please fill in the following fields:</p>
				
				<div class="field">
					<label for="username">User name:</label>
					<input type="text" id="username" name="username" value="" placeholder="User name" class="login" required />
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
				
				{nocache}
				  {foreach from=$keys item=k}
					  {if $fieldIDs[$k] != ""}
						<div class="field">
							<label for="field{$fieldIDs[$k]}">{$fieldNames[$k]}</label>
							<input type="text" id="field{$fieldIDs[$k]}" name="field" value="" placeholder="{$fieldNames[$k]}" class="login" required />
						</div> <!-- /field -->
					  {/if}
				  {/foreach}
				{/nocache}

			</div> <!-- /login-fields -->
			
			<div class="login-actions">
									
				<button tyoe="submit" class="button btn btn-primary btn-large">Register</button>
				
			</div> <!-- .actions -->
			
		</form>
		
	</div> <!-- /content -->
	
</div> <!-- /account-container -->

<!-- Text Under Box -->
<div class="login-extra" style="text-align: center;">
	<a href="passwordLost.php?appID={$appID}">Passwort vergessen?</a> | <a href="login.php?appID={$appID}">Anmelden</a>
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
