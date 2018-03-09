{nocache}
{if $serviceType}
  {assign var='ba' value='onload="switchServiceType(\''|cat:$appID|cat:'\', \''|cat:$serviceID|cat:'\', \''|cat:$serviceType|cat:'\');"'}
{else}
  {assign var='ba' value=''}
{/if}

{include file='templates/modules/header.tpl' title=''|cat:$actionName|cat:' service' ami='apps' bodyargs=$ba}
{/nocache}

<script>
  {literal}
    var queryString = "";

    function editService(ai, si) {
      var sn = document.getElementById("serviceName".toString()).value;
      var st = document.getElementById("serviceType".toString()).value;

      var serviceTypeFields = document.getElementsByName("stfield");

      serviceTypeFields.forEach(setField);

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
              location.replace("services.php?appID="+ai);
            }, 1000);
          } else {
            swal({
              type: "error",
              title: "Couldn't save service",
              text: this.responseText
            });
          }
        }
      }
      xmlhttp.open("GET","functions/editService.php?appID="+ai+"&serviceID="+si+"&serviceName="+sn+"&serviceType="+st+queryString,true);
      xmlhttp.send();
    }

    function setField(item, index) {
      queryString += "&stf_"+item.id+"="+item.value;
    }

    function switchServiceType(ai, si, tn) {
      xmlhttp = new XMLHttpRequest();
      xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          document.getElementById("serviceTypeFields").innerHTML = this.responseText;
        }
      }
      xmlhttp.open("GET","functions/getServiceTypeFields.php?appID="+ai+"&serviceID="+si+"&typeName="+tn,true);
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
              {include file='templates/modules/apptabs.tpl' ata='services'}
              <div class="widget-header"> <i class="icon-link"></i>
                <h3>{$actionName} service</h3>
              </div>
              <div class="widget-content">
                <br />
                  <form id="serviceEdit" class="form-horizontal" style="margin-bottom: 0px;" onsubmit="editService({$appID}, {$serviceID}); return false;">
                    <fieldset>
                      <div class="control-group">
                        <label class="control-label" for="serviceName">Service name:</label>
                        <div class="controls">
                          <input type="text" class="span6" id="serviceName" value="{$serviceName}" required>
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <div class="control-group">
                        <label class="control-label" for="serviceType">Service type:</label>
                        <div class="controls">
                          <select class="span6" id="serviceType" onchange="switchServiceType({$appID}, {$serviceID}, this.value);">
                            <option value="pleaseselect" selected disabled>Please select...</option>   <!-- "selected" can be overwritten by next lines -->
                            {foreach from=$keys item=i}
                              <option value="{$typeNames[$i]}" {if $serviceType == "{$typeNames[$i]}"}selected{/if}>{$typeFullNames[$i]}</option>
                            {/foreach}
                          </select>
                        </div> <!-- /controls -->
                      </div> <!-- /control-group -->

                      <div id="serviceTypeFields">
                        <!-- to be filled by JavaScript -->
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
