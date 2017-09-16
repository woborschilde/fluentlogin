<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
{nocache}
  <title>{$actionName} user group - fluentlogin Administration</title>
{/nocache}
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/bootstrap-responsive.min.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet">
<link href="../css/font-awesome.css" rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">
<link href="../css/pages/dashboard.css" rel="stylesheet">

<!-- Sweetalert Css -->
<link href="../css/sweetalert2.css" rel="stylesheet" />

<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    
<script>
  {literal}
    var queryString = "";

    function editgroup(ai, gi) {
      var gn = document.getElementById("groupName".toString()).value;
      var gd = document.getElementById("groupDescription".toString()).value;
      
      var groupPerms = document.getElementsByName("permission");

      groupPerms.forEach(addPerm);
      
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
              location.replace("groups.php?appID="+ai);
            }, 1000);
          } else {
            swal({
              type: "error",
              title: "Couldn't save group",
              text: this.responseText
            });
          }
        }
      }
      xmlhttp.open("GET","functions/editGroup.php?appID="+ai+"&groupID="+gi+"&groupName="+gn+"&groupDescription="+gd+queryString,true);
      xmlhttp.send();
    }

    function addPerm(item, index) {
      if (item.checked) {
        queryString += "&"+item.id+"=1";
      }
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
              {nocache}
                <h3>{$appName} > {$actionName} user group</h3>
              {/nocache}
            </div>
            <!-- /widget-header -->
            {nocache}
              <div class="widget-content">
                <br />
                  <form id="groupEdit" class="form-horizontal" style="margin-bottom: 0px;" onsubmit="editgroup({$appID}, {$groupID}); return false;">
                    <fieldset>
                      <div class="control-group">
                        <label class="control-label" for="groupName">Group name:</label>
                        <div class="controls">
                          <input type="text" class="span6" id="groupName" value="{$groupName}">
                        </div> <!-- /controls -->				
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <label class="control-label" for="groupDescription">Description:</label>
                        <div class="controls">
                          <input type="text" class="span6" id="groupDescription" value="{$groupDescription}">
                        </div> <!-- /controls -->				
                      </div> <!-- /control-group -->

                      <div class="panel panel-danger" style="margin-left: 2%; width: 60%;">
                        <div class="panel-heading">Permissions for this group</div>
                        <div class="panel-body">
                          {foreach from=$keys item=i}
                            {if $permIDs[$i] != "-"}
                              <label style="width: 40%;"><input type="checkbox" id="perm{$permIDs[$i]}" name="permission" class="filled-in chk-col-red" {$permValues[$i]}><span style="vertical-align: middle;"> {$permNames[$i]}</span></label>
                            {else}
                              {$permNames[$i]} <a href="permissionEdit.php?appID={$appID}" target="_blank"><u>Create</u></a>
                            {/if}
                          {/foreach}
                        </div>
                      </div>

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
