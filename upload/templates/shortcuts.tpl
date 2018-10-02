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
      function delShortcut(i) {
        var r = "shortcutRow"+i.toString();
        var k = document.getElementById("shortcutID"+i.toString()).innerHTML;
        var m = document.getElementById("shortcutText"+i.toString()).innerHTML;
        var a = {/literal}{nocache}{$appID}{/nocache}{literal};

        i++;

        swal({
          title: "Really delete shortcut \""+m+"\"?",
          text: "",
          type: "warning",
          showCancelButton: true,
          confirmButtonColor: '#d33',
          confirmButtonText: 'Yes, delete shortcut',
          cancelButtonText: 'Cancel',
        }).then(function () {
          xmlhttp = new XMLHttpRequest();
          xmlhttp.open("GET","functions/delShortcut.php?appID="+a+"&shortcutID="+k,true);
          xmlhttp.send();
          document.getElementById(r).remove();
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
            <div class="widget-header"> <i class="icon-link"></i>
              <h3>My shortcuts</h3>
              {nocache}
                <span style="text-align: right;"><a href="index.php?appID={$appID}" class="btn btn-info"><b>🠈</b></a></span>
                <span style="text-align: right;"><a href="shortcutEdit.php?appID={$appID}" class="btn btn-primary"><b>+</b>&nbsp;&nbsp;New shortcut</a></span>
              {/nocache}
            </div>
            <!-- /widget-header -->
            <div class="widget-content">
              <table class="table table-striped table-bordered">
                <thead>
                  <tr>
                    <th> Sym. </th>
                    <th> Text </th>
                    <th class="td-actions" style="width: 7%;"> Action </th>
                  </tr>
                </thead>
                <tbody>
                  {nocache}
                    {foreach from=$keys item=i}
                      <tr id="shortcutRow{$i}">
                        <td id="shortcutID{$i}" style="display: none;">{$shortcutIDs[$i]}</td>
                        <td id="shortcutIcon{$i}"><i class="icon-{$shortcutIcons[$i]}" style="color: #{$shortcutIconColors[$i]};"></i></td>
                        <td id="shortcutText{$i}">{$shortcutTexts[$i]}</td>
                        <td class="td-actions btn-group">
                          {if $shortcutIDs[$i] != "-"}
                            <a href="shortcutEdit.php?appID={$appID}&shortcutID={$shortcutIDs[$i]}" class="btn btn-small btn-success" style="margin-right: 0px;"><i class="btn-icon-only icon-pencil"> </i></a>
                            <a href="javascript:;" class="btn btn-small btn-danger" onclick="delShortcut({$i});"><i class="btn-icon-only icon-remove"> </i></a>
                          {/if}
                        </td>
                      </tr>
                    {/foreach}
                  {/nocache}
                </tbody>
              </table>
            </div>
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
