{nocache}
  {include file='templates/modules/header.tpl' title='Services' ami='apps'}
{/nocache}

<script>
		{literal}
      function delService(i) {
        var r = "serviceRow"+i.toString();
        var k = document.getElementById("serviceID"+i.toString()).innerHTML;
        var m = document.getElementById("serviceName"+i.toString()).innerHTML;

        i++;

        swal({
          title: "Really delete service \""+m+"\"?",
          text: "All links will be removed.",
          type: "warning",
          showCancelButton: true,
          confirmButtonColor: '#d33',
          confirmButtonText: 'Yes, delete service',
          cancelButtonText: 'Cancel',
        }).then(function () {
          xmlhttp = new XMLHttpRequest();
          xmlhttp.open("GET","functions/delService.php?serviceID="+k,true);
          xmlhttp.send();
          document.getElementById(r).remove();
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
              {include file='templates/modules/apptabs.tpl' ata='services'}
            {/nocache}
            <div class="widget-header">&nbsp;
              {nocache}
                <span style="text-align: right;"><a href="serviceEdit.php?appID={$appID}" class="btn btn-violet"><b>+</b>&nbsp;&nbsp;New service</a></span>
              {/nocache}
            </div>
            <!-- /widget-header -->
            <div class="widget-content">
              <table class="table table-striped table-bordered">
                <thead>
                  <tr>
                    <th> ID </th>
                    <th> Name </th>
                    <th class="td-actions" style="width: 7%;"> Action </th>
                  </tr>
                </thead>
                <tbody>
                  {nocache}
                    {foreach from=$keys item=i}
                      <tr id="serviceRow{$i}">
                        <td id="serviceID{$i}">{$serviceIDs[$i]}</td>
                        <td id="serviceName{$i}">{$serviceNames[$i]}</td>
                        <td class="td-actions btn-group">
                          {if $serviceIDs[$i] != "-"}
                            <a href="serviceEdit.php?appID={$appID}&serviceID={$serviceIDs[$i]}" class="btn btn-small btn-success" style="margin-right: 0px;"><i class="btn-icon-only icon-pencil"> </i></a>
                            <a href="javascript:;" class="btn btn-small btn-danger" onclick="delService({$i});"><i class="btn-icon-only icon-remove"> </i></a>
                          {/if}
                        </td>
                      </tr>
                    {/foreach}
                  {/nocache}
                </tbody>
              </table>
            </div>
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
