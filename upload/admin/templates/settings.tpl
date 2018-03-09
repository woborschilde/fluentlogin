{nocache}
  {include file='templates/modules/header.tpl' title='System settings' ami='system'}
{/nocache}

<script>
  {literal}
    var queryString = "";

    function editSettings() {
      var settings = document.getElementsByName("setting");

      settings.forEach(setSetting);

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
              location.replace("index.php");
            }, 1000);
          } else {
            swal({
              type: "error",
              title: "Couldn't save settings",
              text: this.responseText
            });
          }
        }
      }
      xmlhttp.open("GET","functions/editSettings.php?"+queryString,true);
      xmlhttp.send();
    }

    function setSetting(item, index) {
      queryString += "&"+item.id+"="+item.value;
    }

    function showApiKey() {
      var apikey = {/literal}{nocache}{$keyID}{/nocache}{literal};

      swal({
        title: "Show API Key?",
        html: "With the API Key, you can access parts of the fluentlogin database by URL call. Please keep this key secret as everybody can authenticate at the API with it!<br /><a href='https://intra.woborschil.net/docs/en/fluentlogin/api' target='_blank'>Learn more about the API</a><br /><br />Show your key now?",
        type: "question",
        showCancelButton: true,
        confirmButtonText: "Yes"
      }).then(function () {
        swal({
          title: "Your API Key is",
          html: "<b>"+apikey+"</b>",
          type: "info"
        });
      });
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
            <div class="widget-header"> <i class="icon-cog"></i>
              <h3>System settings</h3>
            </div>
            <!-- /widget-header -->
            {nocache}
              <div class="widget-content">
                <br />
                  <form id="userEdit" class="form-horizontal" style="margin-bottom: 0px;" onsubmit="editSettings(); return false;">
                    <fieldset>
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

                      <div class="control-group">
                        <label class="control-label">API Key:</label>
                        <div class="controls" style="margin-top: 3px;">
                          <a href="#" onclick="showApiKey();"><u>Show</u></a>
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <label class="control-label">Template cache:</label>
                        <div class="controls" style="margin-top: 3px;">
                          <a href="deleteCache.php" target="_blank"><u>Refresh</u></a>
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

{nocache}
  {include file='templates/modules/footer.tpl'}
{/nocache}
