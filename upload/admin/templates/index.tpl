{nocache}
  {include file='templates/modules/header.tpl' title='Dashboard' ami='dashboard'}
{/nocache}

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
                <a href="apps.php" class="shortcut" style="width: 14%;"><i class="shortcut-icon icon-list-alt"></i><span class="shortcut-label">Applications</span></a>
                <a href="admins.php" class="shortcut" style="width: 14%;"><i class="shortcut-icon icon-legal"></i><span class="shortcut-label">Administrators</span></a>
                <a href="plugins.php" class="shortcut" style="width: 14%;"><i class="shortcut-icon icon-leaf"></i><span class="shortcut-label">Plugin Manager</span></a>
                <a href="settings.php" class="shortcut" style="width: 14%;"><i class="shortcut-icon icon-cog"></i><span class="shortcut-label">System settings</span></a>
                <a href="https://intra.woborschil.net/docs/en/fluentlogin/start" target="_blank" class="shortcut" style="width: 14%;"><i class="shortcut-icon icon-book"></i><span class="shortcut-label">Documentation</span></a>
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

{nocache}
  {include file='templates/modules/footer.tpl'}
{/nocache}
