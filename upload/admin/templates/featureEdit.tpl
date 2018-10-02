{nocache}
  {include file='templates/modules/header.tpl' title=''|cat:$actionName|cat:' feature' ami='apps'}
{/nocache}

<script>
  {literal}
    var queryString = "";

    function editFeature(ai, fi) {
      var sta = encodeURIComponent(document.getElementById("shortcutTarget".toString()).value);
      var ste = encodeURIComponent(document.getElementById("shortcutText".toString()).value);
      var si = document.getElementById("shortcutIcon".toString()).value;
      var sic = encodeURIComponent(document.getElementById("shortcutIconColor".toString()).value);
      var sp = document.getElementById("shortcutPosition".toString()).value;

      var featureGroups = document.getElementsByName("group");
      var featureUsers = document.getElementsByName("user");

      featureGroups.forEach(addGroup);
      featureUsers.forEach(addUser);

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
              location.replace("features.php?appID="+ai);
            }, 1000);
          } else {
            swal({
              type: "error",
              title: "Couldn't save feature",
              html: this.responseText
            });
          }
        }
      }
      xmlhttp.open("GET","functions/editFeature.php?appID="+ai+"&featureID="+fi+"&shortcutTarget="+sta+"&shortcutText="+ste+"&shortcutIcon="+si+"&shortcutIconColor="+sic+"&shortcutPosition="+sp+queryString,true);
      xmlhttp.send();
    }

    function addGroup(item, index) {
      if (item.checked) {
        queryString += "&"+item.id+"=1";
      }
    }

    function addUser(item, index) {
      if (item.checked) {
        queryString += "&"+item.id+"=1";
      }
    }

    function showIcons() {
      swal({
        title: "Available icons",
        html: "<iframe src='../icons.html' width='400px' height='500px'></iframe>",
        animation: false
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
            {nocache}
              {include file='templates/modules/apptabs.tpl' ata='features'}
              <div class="widget-header"> <i class="icon-group"></i>
                <h3>{$actionName} feature</h3>
              </div>
              <div class="widget-content">
                <br />
                  <form id="groupEdit" class="form-horizontal" style="margin-bottom: 0px;" onsubmit="editFeature({$appID}, {$featureID}); return false;">
                    <fieldset>
                      <div class="control-group">
                        <label class="control-label" for="shortcutTarget">Shortcut target:</label>
                        <div class="controls">
                          <input type="text" class="span6" id="shortcutTarget" value="{$shortcutTarget}" required>
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <label class="control-label" for="shortcutText">Text:</label>
                        <div class="controls">
                          <input type="text" class="span6" id="shortcutText" value="{$shortcutText}" required>
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <div class="control-group" style="margin-bottom: 0px;">
                        <label class="control-label" for="shortcutIcon">Icon:</label>
                        <div class="controls">
                          icon-<input type="text" class="span6" style="width: 210px;" id="shortcutIcon" value="{$shortcutIcon}">
                          <div style="margin-top: -25px; margin-left: 260px;"><span onclick="showIcons();" style="color: #00ba8b; text-decoration: underline; cursor: pointer;">Show available icons</span></div><br />
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <label class="control-label" for="shortcutIconColor">Icon color:</label>
                        <div class="controls">
                          <input class="jscolor" id="shortcutIconColor" value="{$shortcutIconColor}">
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <label class="control-label" for="shortcutPosition">Position:</label>
                        <div class="controls">
                          <input type="text" class="span6" id="shortcutPosition" value="{$shortcutPosition}">
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <div class="panel panel-warning" style="margin-left: 2%; width: 60%;">
                        <div class="panel-heading">Groups able to see this feature</div>
                        <div class="panel-body">
                          {foreach from=$keys item=i}
                            {if $groupIDs[$i] != "-"}
                              <label style="width: 40%;"><input type="checkbox" id="group{$groupIDs[$i]}" name="group" class="filled-in chk-col-red" {$groupValues[$i]}><span style="vertical-align: middle;"> {$groupNames[$i]}</span></label>
                            {else}
                              {$groupNames[$i]} <a href="groupEdit.php?appID={$appID}" target="_blank"><u>Create</u></a>
                            {/if}
                          {/foreach}
                        </div>
                      </div>

                      <div class="panel panel-info" style="margin-left: 2%; width: 60%;">
                        <div class="panel-heading">Additional users able to see this feature</div>
                        <div class="panel-body">
                          {foreach from=$keys2 item=i}
                            {if $userIDs[$i] != "-"}
                              <label style="width: 40%;"><input type="checkbox" id="user{$userIDs[$i]}" name="user" class="filled-in chk-col-red" {$userValues[$i]}><span style="vertical-align: middle;"> {$userNames[$i]}</span></label>
                            {else}
                              {$userNames[$i]} <a href="userEdit.php?appID={$appID}" target="_blank"><u>Create</u></a>
                            {/if}
                          {/foreach}
                        </div>
                      </div>

                      <div class="alert alert-info" style="margin-left: 2%; width: 60%;">
                        <b>Notice:</b> The above settings do not actually limit users' access permissions to the specific resource. They only define its visibility on their fluentlogin dashboards. However, users can still grab the resource by the target link.
                      </div>

                      <div class="alert alert-info" style="margin-left: 2%; width: 60%;">
                        <b>Notice:</b> Leave all boxes above unchecked in order to make this feature visible for all users ("common service").
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

{nocache}
  {include file='templates/modules/footer.tpl'}
{/nocache}
