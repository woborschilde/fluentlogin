{nocache}
  {include file='templates/modules/header.tpl'}
{/nocache}

<div class="main">
  <div class="main-inner">
    <div class="container">
      <div class="row">
        <!-- /span6 -->
        <div class="span6" style="width: 100%;">
          <div class="widget">
            <div class="widget-header"> <i class="icon-bookmark"></i>
              <h3>Features</h3>
            </div>
            <!-- /widget-header -->
            <div class="widget-content">
              {nocache}
                <h1>Hello, {$userName}!</h1>
                <div class="shortcuts">
                  <a href="settings.php?appID={$appID}" class="shortcut"><i class="shortcut-icon icon-cog" style="color: #1565c0;"></i><span class="shortcut-label">My settings</span></a>
                  <a href="logout.php?appID={$appID}" class="shortcut"><i class="shortcut-icon icon-signout" style="color: #b71c1c;"></i><span class="shortcut-label">Log out</span></a>
                </div>
              {/nocache}
              <!-- /shortcuts -->
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
