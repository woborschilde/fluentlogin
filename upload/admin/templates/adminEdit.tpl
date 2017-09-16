<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
{nocache}
  <title>{$actionName} admin - fluentlogin Administration</title>
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

    function editAdmin(adi) {
      var an = document.getElementById("adminNameField".toString()).value;
      var ap = sha1(document.getElementById("adminPasswordField".toString()).value);
      
      var sos = {/literal}{nocache}"{$sos}"{/nocache}{literal};

      //var adminFields = document.getElementsByName("field");
      //var adminGroups = document.getElementsByName("group");

      //adminGroups.forEach(assign);
      
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
              location.replace("admins.php");
            }, 1000);
          } else {
            swal({
              type: "error",
              title: "Couldn't save admin",
              text: this.responseText
            });
          }
        }
      }
      xmlhttp.open("GET","functions/editAdmin.php?adminIDField="+adi+"&adminNameField="+an+"&adminPasswordField="+ap+sos,true);
      xmlhttp.send();
    }

    /* function assign(item, index) {
      if (item.checked) {
        queryString += "&"+item.id+"=1";
      }
    } */
  {/literal}
</script>

</head>
<body>
<div class="navbar navbar-fixed-top">
  <div class="navbar-inner">
    <div class="container"> <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"><span
                    class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span> </a><a class="brand" href="index.php">fluentlogin Administration{nocache}{if $sosok} - SOS Mode{/if}{/nocache}</a>
      <div class="nav-collapse">
        <ul class="nav pull-right">
          {nocache}
            <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-user"></i> {$adminName}{if !$sosok}<b class="caret"></b>{/if}</a>
              {if !$sosok}
                <ul class="dropdown-menu">
                  <li><a href="functions/doLogout.php">Log out</a></li>
                </ul>
              {/if}
            </li>
          {/nocache}
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
        <li><a href="apps.php"><i class="icon-list-alt"></i><span>Applications</span> </a> </li>
        <li class="active"><a href="admins.php"><i class="icon-legal"></i><span>Administrators</span> </a></li>
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
            <div class="widget-header"> <i class="icon-legal"></i>
              {nocache}
                <h3>Administrators > {$actionName} admin</h3>
              {/nocache}
            </div>
            <!-- /widget-header -->
            {nocache}
              <div class="widget-content">
                <br />
                  <form id="adminEdit" class="form-horizontal" style="margin-bottom: 0px;" onsubmit="editAdmin({$adminIDField}); return false;">
                    <fieldset>

                      {if $sos && !$sosok}
                        <div class="alert alert-info" style="margin-left: 2%; width: 60%;">
                          No need for SOS Mode. ;)
                        </div>
                      {/if}

                      <div class="control-group">
                        <label class="control-label" for="adminNameField">Admin name:</label>
                        <div class="controls">
                          <input type="text" class="span6" id="adminNameField" value="{$adminNameField}">
                        </div> <!-- /controls -->				
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <label class="control-label" for="adminPasswordField">Password:</label>
                        <div class="controls">
                          <input type="password" class="span6" id="adminPasswordField" value="" {if $sos}placeholder="Please specify a new password for admin 1." required{else}placeholder="Leave empty to stay unchanged"{/if}>
                        </div> <!-- /controls -->				
                      </div> <!-- /control-group -->

                      <!-- <div class="panel panel-warning" style="margin-left: 2%; width: 60%;">
                        <div class="panel-heading">Assigned admin apps</div>
                        <div class="panel-body">
                          {foreach from=$keys item=i}
                            {if $appIDs[$i] != "-"}
                              <label style="width: 40%;"><input type="checkbox" id="app{$appIDs[$i]}" name="app" class="filled-in chk-col-red" {$appValues[$i]}><span style="vertical-align: middle;"> {$appNames[$i]}</span></label>
                            {else}
                              {$appNames[$i]} <a href="appEdit.php?appID={$appID}" target="_blank"><u>Create</u></a>
                            {/if}
                          {/foreach}
                        </div>
                      </div> -->
                      
                      {if $selfWarning == 1 && !$sosok}
                        <div class="alert alert-warning" style="margin-left: 2%; width: 60%;">
                          <b>Warning!</b> You are about to edit your own administrative account. You may lose access to the fluentlogin Administration Panel when making mistakes.
                        </div>
                      {elseif $selfWarning == 0 && !$sosok}
                        <div class="alert alert-danger" style="margin-left: 2%; width: 60%;">
                          <b>Beware!</b> Administrators have full access to all settings of this fluentlogin installation.
                        </div>
                      {/if}

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

<!-- SHA-1 Plugin Js -->
<script src="../js/sha1.min.js"></script>

<script src="../js/base.js"></script> 

</body>
</html>
