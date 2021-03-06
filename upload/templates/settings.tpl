<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
{nocache}
  <title>My settings - {$appName}</title>
{/nocache}
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet">
<link href="css/font-awesome.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link href="css/pages/dashboard.css" rel="stylesheet">

<!-- Sweetalert Css -->
<link href="css/sweetalert2.css" rel="stylesheet" />

<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    
<script>
  {literal}
    var queryString = "";

    function editSettings(ai) {
      var ue = document.getElementById("userEmail".toString()).value;
      var up = document.getElementById("userPassword".toString()).value;
      var np = document.getElementById("newPassword".toString()).value;
      var nc = document.getElementById("newPasswordConfirm".toString()).value;
      
      if (np != nc) {
				swal({
					type: "error",
					title: "Couldn't save your settings",
					text: "The entered new passwords do not match."
				});
				return;
			}

      if (up == np && up != "") {
				swal({
					type: "error",
					title: "Couldn't save your settings",
					text: "Your new password can't be the same as your current password."
				});
				return;
			}

      xmlhttp = new XMLHttpRequest();
      xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          if (this.responseText == "1") {
            swal({
              type: "success",
              title: "Settings updated",
              text: "Your changes have been saved successfully."
            });
            setTimeout(function(){
              {/literal}{nocache}
								location.replace("{$redirect_after_save}"+"?appID="+ai);
							{/nocache}{literal}
            }, 1000);
          } else {
            swal({
              type: "error",
              title: "Couldn't save your settings",
              html: this.responseText
            });
          }
        }
      }
      xmlhttp.open("GET","functions/editSettings.php?appID="+ai+"&userEmail="+ue+"&userPassword="+sha1(up)+"&newPassword="+sha1(np),true);
      xmlhttp.send();
    }
  {/literal}
</script>

</head>
<body>
<div class="navbar navbar-fixed-top">
  <div class="navbar-inner" style="background: {nocache}{$colorHeaderBackground}{/nocache} !important;">
    <div class="container"> <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"><span
                    class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span> </a><a class="brand" href="index.php?appID={$appID}">{$appName}</a>
      <div class="nav-collapse">
        <ul class="nav pull-right">
          <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-user"></i> {$userName}<b class="caret"></b></a>
            <ul class="dropdown-menu">
              <li><a href="settings.php?appID={$appID}">My settings</a></li>
              <li><a href="functions/doLogout.php?appID={$appID}&userID={$userID}">Log out</a></li>
            </ul>
          </li>
        </ul>
      </div>
      <!--/.nav-collapse --> 
    </div>
    <!-- /container --> 
  </div>
  <!-- /navbar-inner --> 
</div>
<!-- /navbar -->
<br />
<div class="main">
  <div class="main-inner">
    <div class="container">
      <div class="row">
        <!-- /span6 -->
        <div class="span6" style="width: 100%;">
          <div class="widget widget-table action-table">
            <div class="widget-header"> <i class="icon-list-alt"></i>
              <h3>My settings</h3>
            </div>
            <!-- /widget-header -->
            {nocache}
              <div class="widget-content">
                <br />
                  <form id="userEdit" class="form-horizontal" style="margin-bottom: 0px;" onsubmit="editSettings({$appID}); return false;">
                    <fieldset>
                      <h3 style="margin-left: 26px;">Change your e-mail</h3><br />
                      <div class="control-group">
                        <label class="control-label" for="userEmail">E-mail:</label>
                        <div class="controls">
                          <input type="email" class="span6" id="userEmail" value="{$userEmail}">
                        </div> <!-- /controls -->				
                      </div> <!-- /control-group -->

                      <h3 style="margin-left: 26px;">Change your password</h3><br />
                      <div class="control-group">
                        <label class="control-label" for="userPassword">Current Password:</label>
                        <div class="controls">
                          <input type="password" class="span6" id="userPassword" value="" placeholder="Only enter if you want to change your password">
                        </div> <!-- /controls -->				
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <label class="control-label" for="newPassword">New Password:</label>
                        <div class="controls">
                          <input type="password" class="span6" id="newPassword" value="" placeholder="Leave empty to stay unchanged">
                        </div> <!-- /controls -->				
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <label class="control-label" for="newPasswordConfirm">Confirm New Password:</label>
                        <div class="controls">
                          <input type="password" class="span6" id="newPasswordConfirm" value="" placeholder="Leave empty to stay unchanged">
                        </div> <!-- /controls -->				
                      </div> <!-- /control-group -->

                      <div class="form-actions" style="margin-bottom: 0px;">
                        <button type="submit" class="btn btn-primary">Save</button> 
                        <a class="btn" onclick="window.history.back();">Cancel</a>
                      </div> <!-- /form-actions -->
                    </fieldset>
                  </form>
              </div>
            {/nocache}
            <!-- /widget-content --> 
          </div>
        </div>
        <!-- /span6 --> 
      </div>
      <!-- /row --> 
    </div>
    <!-- /container --> 
  </div>
  <!-- /main-inner --> 
</div>
<!-- /main -->
<div class="footer">
  <div class="footer-inner">
    <div class="container">
      <div class="row">
        <div class="span12"> &copy; 2017 <a href="http://www.woborschil.de/fluentlogin" target="_blank"><b>fluentlogin</b></a>, developed by <a href="http://www.woborschil.de" target="_blank"><b>woborschil.de</b></a>. Template: &copy; 2013 <a href="https://www.egrappler.com/templatevamp-twitter-bootstrap-admin-template-now-available/" target="_blank"><b>Bootstrap Responsive Admin Template</b></a>.</div>
        <!-- /span12 --> 
      </div>
      <!-- /row --> 
    </div>
    <!-- /container --> 
  </div>
  <!-- /footer-inner --> 
</div>
<!-- /footer --> 
<!-- Le javascript
================================================== --> 
<!-- Placed at the end of the document so the pages load faster --> 
<script src="js/jquery-1.7.2.min.js"></script> 
<script src="js/excanvas.min.js"></script> 
<script src="js/chart.min.js" type="text/javascript"></script> 
<script src="js/bootstrap.js"></script>
<script language="javascript" type="text/javascript" src="js/full-calendar/fullcalendar.min.js"></script>

<!-- SweetAlert Plugin Js -->
<script src="js/sweetalert2.min.js"></script>

<!-- SHA-1 Plugin Js -->
<script src="js/sha1.min.js"></script>

<script src="js/base.js"></script> 

</body>
</html>
