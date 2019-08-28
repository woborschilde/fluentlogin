{nocache}
  {include file='templates/modules/header.tpl' title='Administrators' ami='admins'}
{/nocache}

<script>
		{literal}
      function delAdmin(i) {
        var r = "adminRow"+i.toString();
        var k = document.getElementById("adminID"+i.toString()).innerHTML;
        var m = document.getElementById("adminName"+i.toString()).innerHTML;

        i++;

        swal({
          title: "Really delete admin \""+m+"\"?",
          text: "He/She will lose access to this fluentlogin Administration.\nHis/Her login logs will be removed.",
          type: "warning",
          showCancelButton: true,
          confirmButtonColor: '#d33',
          confirmButtonText: 'Yes, delete admin',
          cancelButtonText: 'Cancel',
        }).then(function () {
          xmlhttp = new XMLHttpRequest();
          xmlhttp.open("GET","functions/delAdmin.php?adminToDeleteID="+k,true);
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
            <div class="widget-header"> <i class="icon-legal"></i>
              <h3>Administrators</h3>
              <span style="text-align: right;"><a href="adminEdit.php" class="btn btn-danger"><b>+</b>&nbsp;&nbsp;New admin</a></span>
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
                      <tr id="adminRow{$i}">
                        <td id="adminID{$i}">{$adminIDs[$i]}</td>
                        <td id="adminName{$i}">{$adminNames[$i]}</td>
                        <td class="td-actions btn-group">
                          {if $adminNames[$i] != "No admins created yet."}
                            <a href="adminEdit.php?adminID={$adminIDs[$i]}" class="btn btn-small btn-success" style="margin-right: 0px;"><i class="btn-icon-only icon-pencil"> </i></a>
                            {if $adminIDs[$i] != $adminID}
                              {if $adminIDs[$i] != "1"}
                                <a href="javascript:;" class="btn btn-small btn-danger" onclick="delAdmin({$i});"><i class="btn-icon-only icon-remove"> </i></a>
                              {else}
                              <a href="javascript:;" class="btn btn-small btn-danger disabled" data-balloon="Admin #1 can't be deleted!" data-balloon-pos="left"><i class="btn-icon-only icon-remove"> </i></a>
                              {/if}
                            {else}
                              <a href="javascript:;" class="btn btn-small btn-danger disabled" data-balloon="You can't delete yourself!" data-balloon-pos="left"><i class="btn-icon-only icon-remove"> </i></a>
                            {/if}
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
