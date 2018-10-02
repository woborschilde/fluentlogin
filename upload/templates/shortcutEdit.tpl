<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
{nocache}
  <title>My shortcuts - {$appName}</title>
{/nocache}
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
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
    function editShortcut(ai, si) {
      var sid = document.getElementById("shortcutID".toString()).value;
      var sta = encodeURIComponent(document.getElementById("shortcutTarget".toString()).value);
      var ste = encodeURIComponent(document.getElementById("shortcutText".toString()).value);
      var si = document.getElementById("shortcutIcon".toString()).value;
      var sic = encodeURIComponent(document.getElementById("shortcutIconColor".toString()).value);
      var sp = document.getElementById("shortcutPosition".toString()).value;

      xmlhttp = new XMLHttpRequest();
      xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          if (this.responseText == "1") {
            swal({
              type: "success",
              title: "Saved",
              text: "Your changes have been saved successfully."
            });
            setTimeout(function(){
              location.replace("shortcuts.php?appID="+ai);
            }, 1000);
          } else {
            swal({
              type: "error",
              title: "Couldn't save shortcut",
              text: this.responseText
            });
          }
        }
      }
      xmlhttp.open("GET","functions/editShortcut.php?appID="+ai+"&shortcutID="+sid+"&shortcutTarget="+sta+"&shortcutText="+ste+"&shortcutIcon="+si+"&shortcutIconColor="+sic+"&shortcutPosition="+sp,true);
      xmlhttp.send();
    }

    function showIcons() {
      swal({
        title: "Available icons",
        html: "<iframe src='icons.html' width='400px' height='500px'></iframe>",
        animation: false
      });
    }
  {/literal}
</script>

</head>
<body>
<div class="navbar navbar-fixed-top">
  <div class="navbar-inner" style="background: {nocache}{$colorHeaderBackground}{/nocache} !important;">
    {nocache}
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
    {/nocache}
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
            {nocache}
              <div class="widget-header"> <i class="icon-link"></i>
                <h3>{$actionName} shortcut</h3>
              </div>
              <div class="widget-content">
                <br />
                  <form id="fieldEdit" class="form-horizontal" style="margin-bottom: 0px;" onsubmit="editShortcut({$appID}, {$shortcutID}); return false;">
                    <fieldset>
                      <input type="hidden" id="shortcutID" value="{$shortcutID}" required>

                      <div class="control-group">
                        <label class="control-label" for="shortcutTarget">Shortcut target:</label>
                        <div class="controls">
                          <input type="text" class="span6" id="shortcutTarget" value="{$shortcutTarget}" required>
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <label class="control-label" for="shortcutText">Text:</label>
                        <div class="controls">
                          <input type="text" class="span6" id="shortcutText" value="{$shortcutText}" required>
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <div class="control-group" style="margin-bottom: 0px;">
                        <label class="control-label" for="shortcutIcon">Icon:</label>
                        <div class="controls">
                          icon-<input type="text" class="span6" style="width: 210px;" id="shortcutIcon" value="{$shortcutIcon}">
                          <div style="margin-top: -25px; margin-left: 260px;"><span onclick="showIcons();" style="color: {$colorHeaderBackground}; text-decoration: underline; cursor: pointer;">Show available icons</span></div><br />
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <label class="control-label" for="shortcutIconColor">Icon color:</label>
                        <div class="controls">
                          <input class="jscolor" id="shortcutIconColor" value="{$shortcutIconColor}">
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <label class="control-label" for="shortcutPosition">Position:</label>
                        <div class="controls">
                          <input type="text" class="span6" id="shortcutPosition" value="{$shortcutPosition}">
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
<script src="js/jscolor.min.js"></script>
<script language="javascript" type="text/javascript" src="js/full-calendar/fullcalendar.min.js"></script>

<!-- SweetAlert Plugin Js -->
<script src="js/sweetalert2.min.js"></script>

<!-- SHA-1 Plugin Js -->
<script src="js/sha1.min.js"></script>

<script src="js/base.js"></script>

</body>
</html>
