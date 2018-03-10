{nocache}
{include file='templates/modules/header.tpl' title=''|cat:$actionName|cat:' field' ami='apps'}
{/nocache}

<script>
  {literal}
    function editField(ai, fi) {
      var fn = document.getElementById("fieldName".toString()).value;
      var fd = document.getElementById("fieldDescription".toString()).value;
      var sol = document.getElementById("showOnLogin".toString()).checked;
      var sor = document.getElementById("showOnRegister".toString()).checked;

      if (sol == true) { sol = "1"; } else { sol = "0"; }
      if (sor == true) { sor = "1"; } else { sor = "0"; }

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
              location.replace("fields.php?appID="+ai);
            }, 1000);
          } else {
            swal({
              type: "error",
              title: "Couldn't save field",
              text: this.responseText
            });
          }
        }
      }
      xmlhttp.open("GET","functions/editField.php?appID="+ai+"&fieldID="+fi+"&fieldName="+fn+"&fieldDescription="+fd+"&showOnLogin="+sol+"&showOnRegister="+sor,true);
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
              {include file='templates/modules/apptabs.tpl' ata='fields'}
              <div class="widget-header"> <i class="icon-table"></i>
                <h3>{$actionName} field</h3>
              </div>
              <div class="widget-content">
                <br />
                  <form id="fieldEdit" class="form-horizontal" style="margin-bottom: 0px;" onsubmit="editField({$appID}, {$fieldID}); return false;">
                    <fieldset>
                      <div class="control-group">
                        <label class="control-label" for="fieldName">Field name:</label>
                        <div class="controls">
                          <input type="text" class="span6" id="fieldName" value="{$fieldName}" required>
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <label class="control-label" for="fieldDescription">Description:</label>
                        <div class="controls">
                          <input type="text" class="span6" id="fieldDescription" value="{$fieldDescription}">
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <div class="controls">
                          <label style="width: 40%;"><input type="checkbox" id="showOnLogin" class="field login-checkbox" {$showOnLogin}><span style="vertical-align: middle;"> Show on login</span></label>
                          <label style="width: 40%;"><input type="checkbox" id="showOnRegister" class="field login-checkbox" {$showOnRegister}><span style="vertical-align: middle;"> Show on registration</span></label>
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
