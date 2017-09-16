<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>fluentlogin Setup</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/bootstrap-responsive.min.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet">
<link href="../css/font-awesome.css" rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">
<link href="../css/pages/dashboard.css" rel="stylesheet">

<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

</head>
<body>
<div class="navbar navbar-fixed-top">
  <div class="navbar-inner">
    <div class="container"> <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"><span
                    class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span> </a><a class="brand" href="index.html">fluentlogin Setup</a> 
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
              <h3>Configure your fluentlogin</h3>
            </div>
            <!-- /widget-header -->
            {nocache}
              <div class="widget-content">
                <br />
                  <form action="finish.php" method="post" class="form-horizontal" style="margin-bottom: 0px;">
                    <fieldset>
                      <h3 style="margin-left: 26px;">Enter server details</h3><br />
                      <div class="control-group">
                        <label class="control-label" for="systemPath">Install path (with trailing slash):</label>
                        <div class="controls">
                          <input type="text" class="span6" id="systemPath" name="systemPath" value="{$systemPath}" placeholder="Example: http://www.mydomain.com/fluentlogin/" required>
                        </div> <!-- /controls -->				
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <label class="control-label" for="supportEmail">Your support e-mail:</label>
                        <div class="controls">
                          <input type="email" class="span6" id="supportEmail" name="supportEmail" value="" placeholder="How can your users reach you? (optional)">
                        </div> <!-- /controls -->				
                      </div> <!-- /control-group -->

                      <h3 style="margin-left: 26px;">Create your administrator account</h3><br />
                      <div class="control-group">
                        <label class="control-label" for="adminName">Your username:</label>
                        <div class="controls">
                          <input type="text" class="span6" id="adminName" name="adminName" value="" placeholder="With these credentials you will log in to the admin panel." required>
                        </div> <!-- /controls -->				
                      </div> <!-- /control-group -->
                      
                      <div class="control-group">
                        <label class="control-label" for="adminPassword">Your password:</label>
                        <div class="controls">
                          <input type="password" class="span6" id="adminPassword" name="adminPassword" value="" placeholder="With these credentials you will log in to the admin panel." required>
                        </div> <!-- /controls -->				
                      </div> <!-- /control-group -->
                      
                      <div class="control-group">
                        <label class="control-label" for="confirmPassword">Confirm your password:</label>
                        <div class="controls">
                          <input type="password" class="span6" id="confirmPassword" name="confirmPassword" value="" placeholder="Type your password again to avoid typos." required>
                        </div> <!-- /controls -->				
                      </div> <!-- /control-group -->

                      <div class="alert alert-info" style="margin-left: 2%; width: 60%;">
                        <b>One last thing</b><br />
                        Please keep in mind that JavaScript and a modern browser is required to use fluentlogin.
                      </div>

                      <hr />

                      <div class="alert alert-info" style="margin-left: 2%; width: 60%;">
                        <b>By continuing, you accept the GPLv3 license terms:</b><br />
                        This program is free software: you can redistribute it and/or modify<br />
                        it under the terms of the GNU General Public License as published by<br />
                        the Free Software Foundation, either version 3 of the License, or<br />
                        (at your option) any later version.<br />
                        <br />
                        This program is distributed in the hope that it will be useful,<br />
                        but WITHOUT ANY WARRANTY; without even the implied warranty of<br />
                        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the<br />
                        GNU General Public License for more details.<br />
                        <br />
                        <a href="../LICENSE.html" target="_blank">Read the full license</a>
                      </div>

                      <div class="form-actions" style="margin-bottom: 0px;">
                        <button type="submit" class="btn btn-primary">Save</button> 
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
        <div class="span12"> &copy; 2017 <a href="http://www.woborschil.de/fluentlogin" target="_blank"><b>fluentlogin Beta 1</b></a>, developed by <a href="http://www.woborschil.de" target="_blank"><b>woborschil.de</b></a>. Template: &copy; 2013 <a href="https://www.egrappler.com/templatevamp-twitter-bootstrap-admin-template-now-available/" target="_blank"><b>Bootstrap Responsive Admin Template</b></a>.</div>
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
<script src="../js/jquery-1.7.2.min.js"></script> 
<script src="../js/excanvas.min.js"></script> 
<script src="../js/chart.min.js" type="text/javascript"></script> 
<script src="../js/bootstrap.js"></script>
<script language="javascript" type="text/javascript" src="../js/full-calendar/fullcalendar.min.js"></script>

<!-- SHA-1 Plugin Js -->
<script src="../js/sha1.min.js"></script>

<script src="../js/base.js"></script> 

</body>
</html>
