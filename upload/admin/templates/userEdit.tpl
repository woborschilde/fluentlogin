{nocache}
  {include file='templates/modules/header.tpl' title=''|cat:$actionName|cat:' user' ami='apps'}
{/nocache}

<script>
  {literal}
    var queryString = "";

    function editUser(ai, ui) {
      var un = document.getElementById("userName".toString()).value;
      var ue = document.getElementById("userEmail".toString()).value;
      var up = sha1(document.getElementById("userPassword".toString()).value);

      var userFields = document.getElementsByName("field");
      var userGroups = document.getElementsByName("group");

      userFields.forEach(setField);
      userGroups.forEach(assign);

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
              location.replace("users.php?appID="+ai);
            }, 1000);
          } else {
            swal({
              type: "error",
              title: "Couldn't save user",
              text: this.responseText
            });
          }
        }
      }
      xmlhttp.open("GET","functions/editUser.php?appID="+ai+"&userID="+ui+"&userName="+un+"&userEmail="+ue+"&userPassword="+up+queryString,true);
      xmlhttp.send();
    }

    function setField(item, index) {
      queryString += "&"+item.id+"="+item.value;
    }

    function assign(item, index) {
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
              {include file='templates/modules/apptabs.tpl' ata='users'}
              <div class="widget-header"> <i class="icon-user"></i>
                <h3>{$actionName} user</h3>
              </div>
              <div class="widget-content">
                <br />
                  <form id="userEdit" class="form-horizontal" style="margin-bottom: 0px;" onsubmit="editUser({$appID}, {$userID}); return false;">
                    <fieldset>
                      <div class="control-group">
                        <label class="control-label" for="userName">Username:</label>
                        <div class="controls">
                          <input type="text" class="span6" id="userName" value="{$userName}">
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <label class="control-label" for="userEmail">E-mail:</label>
                        <div class="controls">
                          <input type="text" class="span6" id="userEmail" value="{$userEmail}">
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <label class="control-label" for="userPassword">Password:</label>
                        <div class="controls">
                          <input type="password" class="span6" id="userPassword" value="" placeholder="Leave empty to stay unchanged">
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <hr />
                      {foreach from=$keys0 item=k}
                        {if $fieldIDs[$k] != "-"}
                          <div class="control-group">
                            <label class="control-label" for="field{$fieldIDs[$k]}">{$fieldNames[$k]}:</label>
                            <div class="controls">
                              <input type="text" class="span6" id="field{$fieldIDs[$k]}" name="field" value="{$fieldValues[$k]}">
                            </div> <!-- /controls -->
                          </div> <!-- /control-group -->
                        {/if}
                      {/foreach}

                      <div class="panel panel-warning" style="margin-left: 2%; width: 60%;">
                        <div class="panel-heading">Assigned user groups</div>
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
