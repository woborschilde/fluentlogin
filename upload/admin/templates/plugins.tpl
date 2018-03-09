{nocache}
  {include file='templates/modules/header.tpl' title='Plugins' ami='plugins'}
{/nocache}

<script>
		{literal}
      function managePlugin(pn, ac) {
        if (ac == "uninstall") {
          swal({
            title: "Really uninstall plugin \""+pn+"\"?",
            text: "All links will be removed.",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: '#d33',
            confirmButtonText: 'Yes, uninstall plugin',
            cancelButtonText: 'Cancel',
          }).then(function () {
            doManagePlugin(pn, ac);
          });
        } else {
          doManagePlugin(pn, ac);
        }
      }

      function doManagePlugin(pn, ac) {
        xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function() {
          if (this.readyState == 4 && this.status == 200) {
            if (this.responseText == "1") {
              var rt = this.responseText;
              swal({
                type: "success",
                title: "Saved",
                text: "Your changes have been saved successfully."
              });
              setTimeout(function(){
                location.replace("plugins.php");
              }, 1000);
            } else {
              swal({
                type: "error",
                title: "Couldn't manage plugin",
                html: this.responseText
              });
            }
          }
        }
        xmlhttp.open("GET", "../plugins/"+pn+"/functions/"+ac+".php",true);
        xmlhttp.send();
      }
    {/literal}
</script>

<div class="main">
  <div class="main-inner">
    <div class="container">
      <div class="row">
        <!-- /span6 -->
        <div class="span6" style="width: 100%;">
          <div class="widget widget-table action-table">
            <div class="widget-header"> <i class="icon-leaf"></i>
              <h3>Plugins</h3>
            </div>
            <!-- /widget-header -->
            <div class="widget-content">
              <table class="table table-striped table-bordered">
                <thead>
                  <tr>
                    <th> ID </th>
                    <th> Name </th>
                    <th> Type </th>
                    <th class="td-actions" style="width: 8%;"> Action </th>
                  </tr>
                </thead>
                <tbody>
                  {nocache}
                    {foreach from=$keys item=i}
                      <tr id="pluginRow{$i}">
                        <td id="pluginID{$i}">{$keys[$i]}</td>
                        <td id="pluginName{$i}">{$pluginNames[$i]}</td>
                        <td id="pluginType{$i}">{if $pluginTypes[$i]}{if $pluginTypes[$i] == "service"}Service provider{else}Normal extension{/if}{else}-{/if}</td>
                        <td class="td-actions btn-group">
                          {if $pluginNames[$i] != "No plugins available."}
                            {if $pluginStatus[$i] == "1"}
                              <a href="#" class="btn btn-small btn-danger" style="margin-right: 0px;" onclick="managePlugin('{$pluginNames[$i]}', 'uninstall');"><i class="btn-icon-only icon-minus"> </i>Uninstall</a>
                            {else}
                              <a href="#" class="btn btn-small btn-primary" style="margin-right: 0px;" onclick="managePlugin('{$pluginNames[$i]}', 'install');"><i class="btn-icon-only icon-plus"> </i>Install</a>
                            {/if}
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

{nocache}
  {include file='templates/modules/footer.tpl'}
{/nocache}
