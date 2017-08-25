<!DOCTYPE html>
<html lang="en">
  
<head>
    <meta charset="utf-8">
    {nocache}
			<title>Anmelden - {$appName}</title>
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

    function login(ai) {
      var un = document.getElementById("username".toString()).value;
      var up = document.getElementById("password".toString()).value;
      
      var userFields = document.getElementsByName("field");
      userFields.forEach(setField);
      
			var re = document.getElementById("remember".toString()).checked;

      xmlhttp = new XMLHttpRequest();
      xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          if (this.responseText == "1") {
            swal({
              type: "success",
              title: "Angemeldet",
              text: "Sie wurden erfolgreich angemeldet."
            });
            setTimeout(function(){
              {/literal}
								location.replace("{$redirect}"+"?appID="+ai);
							{literal}
            }, 1000);
          } else {
            swal({
              type: "error",
              title: "Anmeldung fehlgeschlagen",
              text: this.responseText
            });
          }
        }
      }
      xmlhttp.open("GET","functions/doLogin.php?appID="+ai+"&userName="+un+"&userPassword="+up+queryString+"&remember="+re,true);
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



<div class="account-container">
	
	<div class="content clearfix">
		
		<form onsubmit="login({$appID}); return false;">
		
			<h1>Anmelden bei {nocache}{$appName}{/nocache}</h1>		
			
			<div class="login-fields">
				
				<p>Bitte melden Sie sich an.</p>
				
				<div class="field">
					<label for="username">Benutzername</label>
					<input type="text" id="username" name="username" value="" placeholder="Benutzername" class="login username-field" />
				</div> <!-- /field -->
				
				<div class="field">
					<label for="password">Passwort</label>
					<input type="password" id="password" name="password" value="" placeholder="Passwort" class="login password-field"/>
				</div> <!-- /password -->
				
				{nocache}
				  {foreach from=$keys item=k}
					  {if $fieldIDs[$k] != ""}
						<div class="field">
							<label for="field{$fieldIDs[$k]}">{$fieldNames[$k]}</label>
							<input type="text" id="field{$fieldIDs[$k]}" name="field" value="" placeholder="{$fieldNames[$k]}" class="login username-field" />
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
					<input id="remember" name="remember" type="checkbox" class="field login-checkbox" value="First Choice" tabindex="4" />
					<label class="choice" for="remember">Angemeldet bleiben</label>
				</span>
									
				<button type="submit" class="button btn btn-success btn-large">Anmelden</button>
				
			</div> <!-- .actions -->
			
			
			
		</form>
		
	</div> <!-- /content -->
	
</div> <!-- /account-container -->

<div class="login-extra" style="text-align: center;">
	<a href="passwordLost.php?appID={$appID}">Passwort vergessen?</a> | <a href="license.php?appID={$appID}">Registrieren</a>
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
