{nocache}
  {include file='templates/modules/header.tpl' title=''|cat:$pageTitle|cat:'' ami=''|cat:$ami|cat:''}
{/nocache}

<div class="main">
  <div class="main-inner">
    <div class="container">
      <div class="row">
        <!-- /span6 -->
        <div class="span6" style="width: 100%;">
          <div class="widget widget-table action-table">
            {nocache}
              {if isset($ata)}
                {include file='templates/modules/apptabs.tpl' ata='users'}
              {/if}
              <div class="widget-header"> <i class="{$pageHeadingIcon}"></i>
                <h3>{$pageHeading}</h3>
              </div>
              <!-- /widget-header -->
              <div class="widget-content" style="padding: 16px;">
                {include file='../../plugins/'|cat:$pluginName|cat:'/admin/templates/'|cat:$pageName|cat:'.tpl'}
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
{nocache}
  {include file='templates/modules/footer.tpl'}
{/nocache}
