<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Applications - fluentlogin Administration</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/bootstrap-responsive.min.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600"
        rel="stylesheet">
<link href="../css/font-awesome.css" rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">
<link href="../css/pages/dashboard.css" rel="stylesheet">

<!-- Sweetalert Css -->
<link href="../css/sweetalert2.css" rel="stylesheet" />

<!-- Tooltip Balloon.css -->
<link href="../css/balloon.css" rel="stylesheet" />

<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

<script>
		{literal}
      function delApp(i) {
        var r = "appRow"+i.toString();
        var k = document.getElementById("appID"+i.toString()).innerHTML;
        var m = document.getElementById("appName"+i.toString()).innerHTML;

        i++;

        swal({
          title: "Do you really want to delete \""+m+"\"?",
          text: "All users, user groups, fields and permissions will be removed! This process cannot be undone!",
          type: "warning",
          showCancelButton: true,
          confirmButtonColor: '#d33',
          confirmButtonText: 'Yes, delete application',
          cancelButtonText: 'Cancel',
        }).then(function () {
          xmlhttp = new XMLHttpRequest();
          xmlhttp.open("GET","functions/delApp.php?appID="+k,true);
          xmlhttp.send();
          document.getElementById(r).remove();
        });
      }
    {/literal}
</script>

</head>
<body>
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
        <li><a href="index.php"><i class="icon-dashboard"></i><span>Dashboard</span> </a> </li>
        <li class="active"><a href="apps.php"><i class="icon-list-alt"></i><span>Applications</span> </a> </li>
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
          <div class="widget widget-table action-table">
            <div class="widget-header"> <i class="icon-list-alt"></i>
              <h3>Applications</h3>
              <span style="text-align: right;"><a href="appEdit.php" class="btn btn-success"><b>+</b>&nbsp;&nbsp;New application</a></span>
            </div>
            <!-- /widget-header -->
            <div class="widget-content">
              <table class="table table-striped table-bordered">
                <thead>
                  <tr>
                    <th> ID </th>
                    <th> Name </th>
                    <th class="td-actions" style="width: 28%; text-align: right;"> Action </th>
                  </tr>
                </thead>
                <tbody>
                  {nocache}
                    {foreach from=$keys item=i}
                      <tr id="appRow{$i}">
                        <td id="appID{$i}">{$appIDs[$i]}</td>
                        <td id="appName{$i}">{$appNames[$i]}</td>
                        <td class="td-actions btn-group">
                          {if $appIDs[$i] != "-"}
                            <div style="float: right;">
                              <a href="users.php?appID={$appIDs[$i]}" class="btn btn-small btn-info" style="margin-right: 0px;" data-balloon="Users" data-balloon-pos="up"><i class="btn-icon-only icon-user"> </i></a>
                              <a href="groups.php?appID={$appIDs[$i]}" class="btn btn-small btn-warning" style="margin-right: 0px;" data-balloon="User groups" data-balloon-pos="up"><i class="btn-icon-only icon-asterisk"> </i></a>
                              <a href="fields.php?appID={$appIDs[$i]}" class="btn btn-small btn-primary" style="margin-right: 0px;" data-balloon="Fields" data-balloon-pos="up"><i class="btn-icon-only icon-table"> </i></a>
                              <a href="permissions.php?appID={$appIDs[$i]}" class="btn btn-small btn-danger" style="margin-right: 0px;" data-balloon="Permissions" data-balloon-pos="up"><i class="btn-icon-only icon-legal"> </i></a>
                              <a href="services.php?appID={$appIDs[$i]}" class="btn btn-small btn-violet" style="margin-right: 5px;" data-balloon="Services" data-balloon-pos="up"><i class="btn-icon-only icon-cog"> </i></a>
                              <a href="appEdit.php?appID={$appIDs[$i]}" class="btn btn-small btn-success" style="margin-right: 0px;" data-balloon="Edit" data-balloon-pos="up"><i class="btn-icon-only icon-pencil"> </i></a>
                              <a href="javascript:;" class="btn btn-small btn-danger" onclick="delApp({$i});" style="margin-right: 0px;" data-balloon="Delete" data-balloon-pos="up"><i class="btn-icon-only icon-remove"> </i></a>
                              <a href="../index.php?appID={$appIDs[$i]}" target="_blank" class="btn btn-small btn-primary" style="margin-right: 0px;" data-balloon="App Page" data-balloon-pos="up"><i class="btn-icon-only icon-arrow-right"> </i></a>
                            </div>
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

<!-- SweetAlert Plugin Js -->
<script src="../js/sweetalert2.min.js"></script>

<script src="../js/base.js"></script>

</body>
</html>
