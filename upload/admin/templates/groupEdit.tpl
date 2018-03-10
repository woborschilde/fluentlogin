{nocache}
  {include file='templates/modules/header.tpl' title=''|cat:$actionName|cat:' user group' ami='apps'}
{/nocache}

<script>
  {literal}
    var queryString = "";

    function editgroup(ai, gi) {
      var gn = document.getElementById("groupName".toString()).value;
      var gd = document.getElementById("groupDescription".toString()).value;

      var groupPerms = document.getElementsByName("permission");

      groupPerms.forEach(addPerm);

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
              location.replace("groups.php?appID="+ai);
            }, 1000);
          } else {
            swal({
              type: "error",
              title: "Couldn't save group",
              text: this.responseText
            });
          }
        }
      }
      xmlhttp.open("GET","functions/editGroup.php?appID="+ai+"&groupID="+gi+"&groupName="+gn+"&groupDescription="+gd+queryString,true);
      xmlhttp.send();
    }

    function addPerm(item, index) {
      if (item.checked) {
        queryString += "&"+item.id+"=1";
      }
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
              {include file='templates/modules/apptabs.tpl' ata='groups'}
              <div class="widget-header"> <i class="icon-asterisk"></i>
                <h3>{$actionName} user group</h3>
              </div>
              <div class="widget-content">
                <br />
                  <form id="groupEdit" class="form-horizontal" style="margin-bottom: 0px;" onsubmit="editgroup({$appID}, {$groupID}); return false;">
                    <fieldset>
                      <div class="control-group">
                        <label class="control-label" for="groupName">Group name:</label>
                        <div class="controls">
                          <input type="text" class="span6" id="groupName" value="{$groupName}" required>
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <label class="control-label" for="groupDescription">Description:</label>
                        <div class="controls">
                          <input type="text" class="span6" id="groupDescription" value="{$groupDescription}">
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <div class="panel panel-danger" style="margin-left: 2%; width: 60%;">
                        <div class="panel-heading">Permissions for this group</div>
                        <div class="panel-body">
                          {foreach from=$keys item=i}
                            {if $permIDs[$i] != "-"}
                              <label style="width: 40%;"><input type="checkbox" id="perm{$permIDs[$i]}" name="permission" class="filled-in chk-col-red" {$permValues[$i]}><span style="vertical-align: middle;"> {$permNames[$i]}</span></label>
                            {else}
                              {$permNames[$i]} <a href="permissionEdit.php?appID={$appID}" target="_blank"><u>Create</u></a>
                            {/if}
                          {/foreach}
                        </div>
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
