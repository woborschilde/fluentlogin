{nocache}
  {include file='templates/modules/header.tpl' title=''|cat:$actionName|cat:' admin' ami='admins'}
{/nocache}

<script>
  {literal}
    var queryString = "";

    function editAdmin(adi) {
      var an = document.getElementById("adminNameField".toString()).value;
      var ap = sha1(document.getElementById("adminPasswordField".toString()).value);

      var sos = {/literal}{nocache}"{$sos}"{/nocache}{literal};

      //var adminFields = document.getElementsByName("field");
      //var adminGroups = document.getElementsByName("group");

      //adminGroups.forEach(assign);

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
              location.replace("admins.php");
            }, 1000);
          } else {
            swal({
              type: "error",
              title: "Couldn't save admin",
              text: this.responseText
            });
          }
        }
      }
      xmlhttp.open("GET","functions/editAdmin.php?adminIDField="+adi+"&adminNameField="+an+"&adminPasswordField="+ap+sos,true);
      xmlhttp.send();
    }

    /* function assign(item, index) {
      if (item.checked) {
        queryString += "&"+item.id+"=1";
      }
    } */
  {/literal}
</script>

<div class="main">
  <div class="main-inner">
    <div class="container">
      <div class="row">
        <!-- /span6 -->
        <div class="span6" style="width: 100%;">
          <div class="widget widget-table action-table">
            <div class="widget-header"> <i class="icon-legal"></i>
              {nocache}
                <h3>Administrators > {$actionName} admin</h3>
              {/nocache}
            </div>
            <!-- /widget-header -->
            {nocache}
              <div class="widget-content">
                <br />
                  <form id="adminEdit" class="form-horizontal" style="margin-bottom: 0px;" onsubmit="editAdmin({$adminIDField}); return false;">
                    <fieldset>

                      {if $sos && !$sosok}
                        <div class="alert alert-info" style="margin-left: 2%; width: 60%;">
                          No need for SOS Mode. ;)
                        </div>
                      {/if}

                      <div class="control-group">
                        <label class="control-label" for="adminNameField">Admin name:</label>
                        <div class="controls">
                          <input type="text" class="span6" id="adminNameField" value="{$adminNameField}">
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <label class="control-label" for="adminPasswordField">Password:</label>
                        <div class="controls">
                          <input type="password" class="span6" id="adminPasswordField" value="" {if $sos}placeholder="Please specify a new password for admin 1." required{else}placeholder="Leave empty to stay unchanged"{/if}>
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <!-- <div class="panel panel-warning" style="margin-left: 2%; width: 60%;">
                        <div class="panel-heading">Assigned admin apps</div>
                        <div class="panel-body">
                          {foreach from=$keys item=i}
                            {if $appIDs[$i] != "-"}
                              <label style="width: 40%;"><input type="checkbox" id="app{$appIDs[$i]}" name="app" class="filled-in chk-col-red" {$appValues[$i]}><span style="vertical-align: middle;"> {$appNames[$i]}</span></label>
                            {else}
                              {$appNames[$i]} <a href="appEdit.php?appID={$appID}" target="_blank"><u>Create</u></a>
                            {/if}
                          {/foreach}
                        </div>
                      </div> -->

                      {if $selfWarning == 1 && !$sosok}
                        <div class="alert alert-warning" style="margin-left: 2%; width: 60%;">
                          <b>Warning!</b> You are about to edit your own administrative account. You may lose access to the fluentlogin Administration Panel when making mistakes.
                        </div>
                      {elseif $selfWarning == 0 && !$sosok}
                        <div class="alert alert-danger" style="margin-left: 2%; width: 60%;">
                          <b>Beware!</b> Administrators have full access to all settings of this fluentlogin installation.
                        </div>
                      {/if}

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
