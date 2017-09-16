<!DOCTYPE html>
<html lang="en">
  
<head>
    <meta charset="utf-8">
    {nocache}
			<title>Login - fluentlogin Administration</title>
		{/nocache}

	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <meta name="apple-mobile-web-app-capable" content="yes"> 
    
<link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="../css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />

<link href="../css/font-awesome.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet">
    
<link href="../css/style.css" rel="stylesheet" type="text/css">
<link href="../css/pages/signin.css" rel="stylesheet" type="text/css">

<!-- Sweetalert Css -->
<link href="../css/sweetalert2.css" rel="stylesheet" />

<script>
  {literal}
    function login() {
      var an = document.getElementById("username".toString()).value;
      var ap = sha1(document.getElementById("password".toString()).value);

			swal.showLoading();
      xmlhttp = new XMLHttpRequest();
      xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
					swal.hideLoading();
          if (this.responseText == "1") {
            swal({
              type: "success",
              title: "Logged in",
              text: "You are now logged in."
            });
            setTimeout(function(){
              {/literal}
								location.replace("index.php");
							{literal}
            }, 1000);
          } else {
            swal({
              type: "error",
              title: "Login failed",
              text: this.responseText
            });
          }
        }
      }
      xmlhttp.open("GET","functions/doLogin.php?adminName="+an+"&adminPassword="+ap,true);
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
			
			<a class="brand" href="index.html">
				fluentlogin Administration
			</a>		
			
			<div class="nav-collapse">
				<ul class="nav pull-right">
					<li class="">						
						<a href="" class="" onclick="goBack();">
							<i class="icon-chevron-left"></i>
							Back to previous page
						</a>
					</li>
				</ul>
				
			</div><!--/.nav-collapse -->	
	
		</div> <!-- /container -->
		
	</div> <!-- /navbar-inner -->
	
</div> <!-- /navbar -->

<h1 style="font-size: 42px; color: #333; text-align: center; margin-top: 70px; margin-bottom: 10px;"><span style="color: #00ba8b;">fluent</span>login</h1>
<div style="text-align: center; text-transform: uppercase; letter-spacing: 2px; margin-bottom: -30px;">User Management System</div>

<div class="account-container">
	
	<div class="content clearfix">

		<form onsubmit="login(); return false;">
			
			<div class="login-fields">
				
				<p>Please log in to continue.</p>
				
				<div class="field">
					<label for="username">Username</label>
					<input type="text" id="username" name="username" value="" placeholder="Username" class="login username-field" />
				</div> <!-- /field -->
				
				<div class="field">
					<label for="password">Password</label>
					<input type="password" id="password" name="password" value="" placeholder="Password" class="login password-field"/>
				</div> <!-- /password -->

			</div> <!-- /login-fields -->
			
			<div class="alert alert-info">
				By logging in, you accept cookies to be saved on your computer.
			</div>

			<div class="login-actions">
									
				<button type="submit" class="button btn btn-success btn-large">Log in</button>
				
			</div> <!-- .actions -->
			
		</form>
		
	</div> <!-- /content -->
	
</div> <!-- /account-container -->

<hr />
<div style="color: gray; text-align: center;">
	Powered by <a href="http://www.woborschil.de/fluentlogin" target="_blank" style="color: inherit;"><b>fluentlogin</b></a>
</div>

<script src="../js/jquery-1.7.2.min.js"></script>
<script src="../js/bootstrap.js"></script>

<script src="../js/signin.js"></script>

<!-- SweetAlert Plugin Js -->
<script src="../js/sweetalert2.min.js"></script>

<!-- SHA-1 Plugin Js -->
<script src="../js/sha1.min.js"></script>

</body>

</html>
