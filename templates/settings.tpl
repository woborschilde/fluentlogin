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

      if (up == np) {
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
              location.replace("index.php?appID="+ai);
            }, 1000);
          } else {
            swal({
              type: "error",
              title: "Couldn't save your settings",
              text: this.responseText
            });
          }
        }
      }
      xmlhttp.open("GET","functions/editSettings.php?appID="+ai+"&userPassword="+up+"&newPassword="+np,true);
      xmlhttp.send();
    }
  {/literal}
</script>

</head>
<body>
<div class="navbar navbar-fixed-top">
  <div class="navbar-inner">
    <div class="container"> <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"><span
                    class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span> </a><a class="brand" href="index.html">{$appName}</a>
      <div class="nav-collapse">
        <ul class="nav pull-right">
          <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-user"></i> {$userName}<b class="caret"></b></a>
            <ul class="dropdown-menu">
              <li><a href="javascript:;">My settings</a></li>
              <li><a href="javascript:;">Log out</a></li>
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
                      <h3 style="margin-left: 26px;">Change password</h3><br />
                      <div class="control-group">
                        <label class="control-label" for="userPassword">Current Password:</label>
                        <div class="controls">
                          <input type="password" class="span6" id="userPassword" value="">
                        </div> <!-- /controls -->				
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <label class="control-label" for="newPassword">New Password:</label>
                        <div class="controls">
                          <input type="password" class="span6" id="newPassword" value="" placeholder="Leave empty to unchange">
                        </div> <!-- /controls -->				
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <label class="control-label" for="newPasswordConfirm">Confirm New Password:</label>
                        <div class="controls">
                          <input type="password" class="span6" id="newPasswordConfirm" value="" placeholder="Leave empty to unchange">
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
        <div class="span12"> &copy; 2017 <a href="#"><b>fluentlogin</b></a>, developed by <a href="#"><b>woborschil.de</b></a>. Template: &copy; 2013 <a href="#"><b>Bootstrap Responsive Admin Templat</b>e</a>.</div>
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
