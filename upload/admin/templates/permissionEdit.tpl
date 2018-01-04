{nocache}
  {include file='templates/modules/header.tpl' title=''|cat:$actionName|cat:' permission' ami='apps'}
{/nocache}

<script>
  {literal}
    function editpermission(ai, fi) {
      var fn = document.getElementById("permissionName".toString()).value;
      var fd = document.getElementById("permissionDescription".toString()).value;

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
              location.replace("permissions.php?appID="+ai);
            }, 1000);
          } else {
            swal({
              type: "error",
              title: "Couldn't save permission",
              text: this.responseText
            });
          }
        }
      }
      xmlhttp.open("GET","functions/editPermission.php?appID="+ai+"&permissionID="+fi+"&permissionName="+fn+"&permissionDescription="+fd,true);
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
            {nocache}
              {include file='templates/modules/apptabs.tpl' ata='permissions'}
              <div class="widget-header"> <i class="icon-legal"></i>
                <h3>{$actionName} permission</h3>
              </div>
              <div class="widget-content">
                <br />
                  <form id="permissionEdit" class="form-horizontal" style="margin-bottom: 0px;" onsubmit="editpermission({$appID}, {$permissionID}); return false;">
                    <permissionset>
                      <div class="control-group">
                        <label class="control-label" for="permissionName">Permission name:</label>
                        <div class="controls">
                          <input type="text" class="span6" id="permissionName" value="{$permissionName}">
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <label class="control-label" for="permissionDescription">Description:</label>
                        <div class="controls">
                          <input type="text" class="span6" id="permissionDescription" value="{$permissionDescription}">
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <div class="form-actions" style="margin-bottom: 0px;">
                        <button type="submit" class="btn btn-primary">Save</button>
                        <a class="btn" onclick="window.history.back();">Cancel</a>
                      </div> <!-- /form-actions -->
                    </permissionset>
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
