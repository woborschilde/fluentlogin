{nocache}
  {include file='templates/modules/header.tpl' title=''|cat:$actionName|cat:' application' ami='apps'}
{/nocache}

<script>
  {literal}
    var queryString = "";

    function editApp(ai) {
      var an = document.getElementById("appName".toString()).value;

      var appSettings = document.getElementsByName("setting");

      appSettings.forEach(setSetting);

      xmlhttp = new XMLHttpRequest();
      xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          if (this.responseText.length < 10) {
            var rt = this.responseText;
            swal({
              type: "success",
              title: "Saved",
              text: "Your changes have been saved successfully."
            });
            setTimeout(function(){
              location.replace("appEdit.php?appID="+rt);
            }, 1000);
          } else {
            swal({
              type: "error",
              title: "Couldn't save application",
              text: this.responseText
            });
          }
        }
      }
      xmlhttp.open("GET","functions/editApp.php?appID="+ai+"&appName="+an+queryString,true);
      xmlhttp.send();
    }

    function setSetting(item, index) {
      queryString += "&"+item.id+"="+encodeURIComponent(item.value);
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
            {nocache}
              {include file='templates/modules/apptabs.tpl' ata='general'}
            {/nocache}
            {nocache}
              <div class="widget-content">
                <br />
                  <form id="userEdit" class="form-horizontal" style="margin-bottom: 0px;" onsubmit="editApp({$appID}); return false;">
                    <fieldset>
                      <div class="control-group">
                        <label class="control-label" for="appName">App Name:</label>
                        <div class="controls">
                          <input type="text" class="span6" id="appName" value="{$appName}" required>
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      {foreach from=$keys item=k}
                        {if $settingIDs[$k] != "-"}
                          <div class="control-group">
                            <label class="control-label" for="setting{$settingIDs[$k]}">{$settingNames[$k]}:</label>
                            <div class="controls">
                              <input type="text" class="span6" id="setting{$settingIDs[$k]}" name="setting" value="{$settingValues[$k]}">
                            </div> <!-- /controls -->
                          </div> <!-- /control-group -->
                        {/if}
                      {/foreach}

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

{nocache}
  {include file='templates/modules/footer.tpl'}
{/nocache}
