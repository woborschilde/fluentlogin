<!DOCTYPE html>
<html lang="en">
  
<head>
    <meta charset="utf-8">
    <title>Login - {$appName}</title>

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

<div class="account-container" style="width: 70%;">
	
	<div class="content clearfix">
		
		<form>
		
			<h1>Terms of use</h1>
			You have to read and accept these conditions in order to use <b>{nocache}{$appName}{/nocache}</b>.		
			
			<hr />

			<div class="login-fields">
				<div class="field">
					<textarea class="form-control" id="license" rows="8" style="width: 100%;" readonly>{nocache}{$license}{/nocache}</textarea>
				</div> <!-- /field -->
			</div> <!-- /login-fields -->

			<div class="login-actions">
				<a href="register.php?appID={$appID}" type="submit" class="button btn btn-primary btn-large">Accept</button>
				<a href="" class="button btn btn-default btn-large" style="margin-right: 10px;" onclick="window.history.back();">Decline</a>
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

</body>

</html>
