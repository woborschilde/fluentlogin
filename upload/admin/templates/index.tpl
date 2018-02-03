<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Dashboard - fluentlogin Administration</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/bootstrap-responsive.min.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600"
        rel="stylesheet">
<link href="../css/font-awesome.css" rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">
<link href="../css/pages/dashboard.css" rel="stylesheet">
<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

<script>
  function checkForUpdates() {
    xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        if (this.responseText > 0.1) {
          document.getElementById("updateblock").innerHTML = "fluentlogin Version <b>"+this.responseText+"</b> is available! <a href='http://www.woborschil.de/fluentlogin.htm#xl_greenflow' target='_blank'><u>Download now</u></a>";
        } else {
          document.getElementById("updateblock").innerHTML = "Your fluentlogin is <b>up to date</b>! :)";
        }
      }
    }
    xmlhttp.open("GET","https://intra.woborschil.net/files/fluentlogin-update.html", true);
    xmlhttp.send();
  }
</script>

</head>
<body onload="checkForUpdates();">
<div class="navbar navbar-fixed-top">
  <div class="navbar-inner">
    <div class="container"> <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"><span
                    class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span> </a><a class="brand" href="index.php">fluentlogin Administration</a>
      <div class="nav-collapse">
        <ul class="nav pull-right">
          <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-user"></i> {$adminName}<b class="caret"></b></a>
            <ul class="dropdown-menu">
              <li><a href="functions/doLogout.php">Log out</a></li>
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
<div class="subnavbar">
  <div class="subnavbar-inner">
    <div class="container">
      <ul class="mainnav">
        <li class="active"><a href="index.php"><i class="icon-dashboard"></i><span>Dashboard</span> </a> </li>
        <li><a href="apps.php"><i class="icon-list-alt"></i><span>Applications</span> </a> </li>
        <li><a href="admins.php"><i class="icon-legal"></i><span>Administrators</span> </a></li>
        <li><a href="settings.php"><i class="icon-cog"></i><span>System settings</span> </a></li>
        <li><a href="https://intra.woborschil.net/docs/en/fluentlogin/start" target="_blank"><i class="icon-book"></i><span>Documentation</span> </a> </li>
      </ul>
    </div>
    <!-- /container -->
  </div>
  <!-- /subnavbar-inner -->
</div>
<!-- /subnavbar -->
<div class="main">
  <div class="main-inner">
    <div class="container">
      <div class="row">
        <!-- /span6 -->
        <div class="span6" style="width: 100%;">
          <div class="widget">

            <div id="updateblock" name="updateblock" class="alert alert-info">
              Checking for updates...
            </div>

            <div class="widget-header"> <i class="icon-bookmark"></i>
              <h3>Features</h3>
            </div>
            <!-- /widget-header -->
            <div class="widget-content">
              <div class="shortcuts">
                <a href="apps.php" class="shortcut"><i class="shortcut-icon icon-list-alt"></i><span class="shortcut-label">Applications</span></a>
                <a href="admins.php" class="shortcut"><i class="shortcut-icon icon-legal"></i><span class="shortcut-label">Administrators</span></a>
                <a href="settings.php" class="shortcut"><i class="shortcut-icon icon-cog"></i><span class="shortcut-label">System settings</span></a>
                <a href="https://intra.woborschil.net/docs/en/fluentlogin/start" target="_blank" class="shortcut"><i class="shortcut-icon icon-book"></i><span class="shortcut-label">Documentation</span></a>
              </div>
              <!-- /shortcuts -->
            </div>
            <!-- /widget-content -->
          </div>
          <!-- /widget -->

          <div class="widget">
            <div class="widget-header"> <i class="icon-info-sign"></i>
              <h3>About</h3>
            </div>
            <!-- /widget-header -->
            <div class="widget-content">
              <b>fluentlogin</b> Beta 1 (v0.1), 2017/09/17<br />
              Copyright © 2017, woborschil.de.<br />
              Extensions are copyright of their respective owners.<br />
              <hr />
              <h4>3rd party libraries / Thanks to ...</h4>
              <ul>
                <li><a href="https://www.egrappler.com/templatevamp-twitter-bootstrap-admin-template-now-available/" target="_blank"><b>Bootstrap Responsive Admin Template</b></a> by egrappler.com</li>
                <li><a href="http://fontawesome.io" target="_blank"><b>Font Awesome</b></a> by Dave Gandy</li>
                <li><a href="https://www.smarty.net" target="_blank"><b>Smarty Template Engine</b></a> by New Digital Group, Inc.</li>
                <li><a href="https://intra.woborschil.net/git/idnaos/unscramblephp" target="_blank"><b>UnscramblePHP</b></a> by woborschil.de</li>
              </ul>
              <hr />
              <h4>License</h4>
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
            <!-- /widget-content -->
          </div>
          <!-- /widget -->
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

<script src="../js/base.js"></script>

</body>
</html>
