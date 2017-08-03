<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Benutzer - fluentlogin-Administration</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600"
        rel="stylesheet">
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
      function newApp() {
        var v = "";

        swal({
          title: "Neue Anwendung",
          text: "Geben Sie einen Namen für die neue Anwendung ein.",
          input: "text",
          showCancelButton: true,
          cancelButtonText: "Abbrechen",
          showLoaderOnConfirm: true,
          inputValidator: function(value) {
            return new Promise(function (resolve, reject) {
              xmlhttp = new XMLHttpRequest();
              xmlhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                  if (this.responseText == "1") {
                    resolve();
                  } else {
                    reject(this.responseText);
                  }
                }
              }
              v = value;
              xmlhttp.open("GET","functions/newApp.php?appName="+v,true);
              xmlhttp.send();
            });
          },
        }).then(function () {
          swal({
            type: "success",
            title: "Anwendung erstellt",
            text: "Die Anwendung \""+v+"\" wurde erstellt."
          });
          setTimeout(function(){
            location.replace("apps.php");
          }, 1000);
        });
      }

      function renameApp(i) {
        var v = "";
        var k = document.getElementById("appID"+i.toString()).innerHTML;
        var m = document.getElementById("appName"+i.toString()).innerHTML;

        swal({
          title: "Anwendung umbenennen",
          text: "Geben Sie einen neuen Namen für die Anwendung \""+m+"\" ein.",
          input: "text",
          inputValue: m,
          showCancelButton: true,
          cancelButtonText: "Abbrechen",
          showLoaderOnConfirm: true,
          inputValidator: function(value) {
            return new Promise(function (resolve, reject) {
              xmlhttp = new XMLHttpRequest();
              xmlhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                  if (this.responseText == "1") {
                    resolve();
                  } else {
                    reject(this.responseText);
                  }
                }
              }
              v = value;
              xmlhttp.open("GET","functions/renameApp.php?appID="+k+"&appName="+v,true);
              xmlhttp.send();
            });
          },
        }).then(function () {
          document.getElementById("appName"+i.toString()).innerHTML = v;
        });
      }

      function delApp(i) {
        var r = "appRow"+i.toString();
        var k = document.getElementById("appID"+i.toString()).innerHTML;
        var m = document.getElementById("appName"+i.toString()).innerHTML;
        
        i++;
        
        swal({
          title: "Möchten Sie die Anwendung \""+m+"\" wirklich löschen?",
          text: "Alle Benutzer, Benutzergruppen, Felder und Berechtigungen dieser Anwendung gehen verloren! Dieser Vorgang kann nicht rückgängig gemacht werden.",
          type: "warning",
          showCancelButton: true,
          confirmButtonColor: '#d33',
          confirmButtonText: 'Ja, Anwendung löschen',
          cancelButtonText: 'Abbrechen',
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
                    class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span> </a><a class="brand" href="index.html">fluentlogin-Administration</a>
      <div class="nav-collapse">
        <ul class="nav pull-right">
          <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-user"></i> Ich<b class="caret"></b></a>
            <ul class="dropdown-menu">
              <li><a href="javascript:;">Meine Einstellungen</a></li>
              <li><a href="javascript:;">Abmelden</a></li>
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
        <li class="active"><a href="apps.php"><i class="icon-list-alt"></i><span>Anwendungen</span> </a> </li>
        <li><a href="admins.php"><i class="icon-legal"></i><span>Administratoren</span> </a></li>
        <li><a href="docs.php"><i class="icon-book"></i><span>Dokumentation</span> </a> </li>
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
                <h3>{$appName} > Benutzer</h3>
              {/nocache}
              <span style="text-align: right;"><a class="btn btn-info" onclick="newApp();"><b>+</b>&nbsp;&nbsp;Neuer Benutzer</a></span>
            </div>
            <!-- /widget-header -->
            <div class="widget-content">
              <table class="table table-striped table-bordered">
                <thead>
                  <tr>
                    <th> ID </th>
                    <th> Name </th>
                    <th class="td-actions" style="width: 11%;"> Aktion </th>
                  </tr>
                </thead>
                <tbody>
                  {nocache}
                    {foreach from=$keys item=i}
                      <tr id="userRow{$i}">
                        <td id="userID{$i}">{$userIDs[$i]}</td>
                        <td id="userName{$i}" ondblclick="renameApp({$i});">{$userNames[$i]}</td>
                        <td class="td-actions btn-group">
                          {if $userNames[$i] != "Noch keine Benutzer erstellt."}
                            <a href="javascript:;" class="btn btn-small btn-info" style="margin-right: 0px;"><i class="btn-icon-only icon-user"> </i></a>
                            <a href="javascript:;" class="btn btn-small btn-warning" style="margin-right: 0px;"><i class="btn-icon-only icon-asterisk"> </i></a>
                            <a href="javascript:;" class="btn btn-small btn-success" style="margin-right: 0px;" onclick="renameApp({$i});"><i class="btn-icon-only icon-pencil"> </i></a>
                            <a href="javascript:;" class="btn btn-small btn-danger" onclick="delApp({$i});"><i class="btn-icon-only icon-remove"> </i></a>
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
        <div class="span12"> &copy; 2017 <a href="#"><b>fluentlogin</b></a>, entwickelt von <a href="#"><b>woborschil.de</b></a>. Template: &copy; 2013 <a href="#"><b>Bootstrap Responsive Admin Templat</b>e</a>.</div>
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

<script src="js/base.js"></script> 
<script>     

        var lineChartData = {
            labels: ["January", "February", "March", "April", "May", "June", "July"],
            datasets: [
				{
				    fillColor: "rgba(220,220,220,0.5)",
				    strokeColor: "rgba(220,220,220,1)",
				    pointColor: "rgba(220,220,220,1)",
				    pointStrokeColor: "#fff",
				    data: [65, 59, 90, 81, 56, 55, 40]
				},
				{
				    fillColor: "rgba(151,187,205,0.5)",
				    strokeColor: "rgba(151,187,205,1)",
				    pointColor: "rgba(151,187,205,1)",
				    pointStrokeColor: "#fff",
				    data: [28, 48, 40, 19, 96, 27, 100]
				}
			]

        }

        var myLine = new Chart(document.getElementById("area-chart").getContext("2d")).Line(lineChartData);


        var barChartData = {
            labels: ["January", "February", "March", "April", "May", "June", "July"],
            datasets: [
				{
				    fillColor: "rgba(220,220,220,0.5)",
				    strokeColor: "rgba(220,220,220,1)",
				    data: [65, 59, 90, 81, 56, 55, 40]
				},
				{
				    fillColor: "rgba(151,187,205,0.5)",
				    strokeColor: "rgba(151,187,205,1)",
				    data: [28, 48, 40, 19, 96, 27, 100]
				}
			]

        }    

        $(document).ready(function() {
        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();
        var calendar = $('#calendar').fullCalendar({
          header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
          },
          selectable: true,
          selectHelper: true,
          select: function(start, end, allDay) {
            var title = prompt('Event Title:');
            if (title) {
              calendar.fullCalendar('renderEvent',
                {
                  title: title,
                  start: start,
                  end: end,
                  allDay: allDay
                },
                true // make the event "stick"
              );
            }
            calendar.fullCalendar('unselect');
          },
          editable: true,
          events: [
            {
              title: 'All Day Event',
              start: new Date(y, m, 1)
            },
            {
              title: 'Long Event',
              start: new Date(y, m, d+5),
              end: new Date(y, m, d+7)
            },
            {
              id: 999,
              title: 'Repeating Event',
              start: new Date(y, m, d-3, 16, 0),
              allDay: false
            },
            {
              id: 999,
              title: 'Repeating Event',
              start: new Date(y, m, d+4, 16, 0),
              allDay: false
            },
            {
              title: 'Meeting',
              start: new Date(y, m, d, 10, 30),
              allDay: false
            },
            {
              title: 'Lunch',
              start: new Date(y, m, d, 12, 0),
              end: new Date(y, m, d, 14, 0),
              allDay: false
            },
            {
              title: 'Birthday Party',
              start: new Date(y, m, d+1, 19, 0),
              end: new Date(y, m, d+1, 22, 30),
              allDay: false
            },
            {
              title: 'EGrappler.com',
              start: new Date(y, m, 28),
              end: new Date(y, m, 29),
              url: 'http://EGrappler.com/'
            }
          ]
        });
      });
    </script><!-- /Calendar -->
</body>
</html>
