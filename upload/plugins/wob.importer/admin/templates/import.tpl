<script>
	{literal}
      function importUsers(ai) {
        var db = document.getElementById("database".toString()).value;
        var ta = document.getElementById("table".toString()).value;
        var uc = document.getElementById("usernameColumn".toString()).value;
        var ec = document.getElementById("emailColumn".toString()).value;
        var rc = document.getElementById("regdateColumn".toString()).value;

        xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function() {
          if (this.readyState == 4 && this.status == 200) {
            if (this.responseText > "0") {
              swal({
                type: "success",
                title: "Saved",
                text: this.responseText + " users have been imported successfully."
              }).then(function () {
                location.replace("users.php?appID="+ai);
              });
            } else {
              if (this.responseText == "0") { reason = "No users to import."; } else { reason = this.responseText; }
              swal({
                type: "error",
                title: "Couldn't import users",
                text: reason
              });
            }
          }
        }
        xmlhttp.open("GET","functions/plugin.php?plugin=wob.importer&action=import&appID="+ai+"&database="+db+"&table="+ta+"&usernameColumn="+uc+"&emailColumn="+ec+"&regdateColumn="+rc, true);
        xmlhttp.send();
      }
    {/literal}
</script>

<form id="userImport" class="form-horizontal" style="margin-bottom: 0px;" onsubmit="importUsers('{$appID}'); return false;">
  <fieldset>
    <div class="control-group">
      <label class="control-label" for="database">Database:</label>
      <div class="controls">
        <input type="text" class="span6" id="database" value="" placeholder="Enter the database you would like to import from" required>
      </div> <!-- /controls -->
    </div> <!-- /control-group -->

    <div class="control-group">
      <label class="control-label" for="table">Table:</label>
      <div class="controls">
        <input type="text" class="span6" id="table" value="" placeholder="Enter the database table you would like to import from" required>
      </div> <!-- /controls -->
    </div> <!-- /control-group -->

    <div class="control-group">
      <label class="control-label" for="usernameColumn">Username column:</label>
      <div class="controls">
        <input type="text" class="span6" id="usernameColumn" value="" placeholder="Enter the name of the username column" required>
      </div> <!-- /controls -->
    </div> <!-- /control-group -->

    <div class="control-group">
      <label class="control-label" for="emailColumn">E-mail column:</label>
      <div class="controls">
        <input type="text" class="span6" id="emailColumn" value="" placeholder="Enter the name of the e-mail column (optional)">
      </div> <!-- /controls -->
    </div> <!-- /control-group -->

    <div class="control-group">
      <label class="control-label" for="regdateColumn">Registration date column:</label>
      <div class="controls">
        <input type="text" class="span6" id="regdateColumn" value="" placeholder="Enter the name of the registration date column, must be in unix timestamp format (optional)">
      </div> <!-- /controls -->
    </div> <!-- /control-group -->

    The imported users will be added to the user list.<br />
    Passwords can't be copied.

    <div class="form-actions" style="margin-bottom: 0px;">
      <button type="submit" class="btn btn-primary">Import</button>
      <a class="btn" onclick="window.history.back();">Cancel</a>
    </div> <!-- /form-actions -->
  </fieldset>
</form>
