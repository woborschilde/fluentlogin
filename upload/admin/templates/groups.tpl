{nocache}
  {include file='templates/modules/header.tpl' title='User groups' ami='apps'}
{/nocache}

<script>
		{literal}
      function delGroup(a, i) {
        var r = "groupRow"+i.toString();
        var k = document.getElementById("groupID"+i.toString()).innerHTML;
        var m = document.getElementById("groupName"+i.toString()).innerHTML;

        i++;

        swal({
          title: "Really delete user group \""+m+"\"?",
          text: "All links will be removed.",
          type: "warning",
          showCancelButton: true,
          confirmButtonColor: '#d33',
          confirmButtonText: 'Yes, delete user group',
          cancelButtonText: 'Cancel',
        }).then(function () {
          xmlhttp = new XMLHttpRequest();
          xmlhttp.open("GET","functions/delGroup.php?appID="+a+"&groupID="+k,true);
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
              {include file='templates/modules/apptabs.tpl' ata='groups'}
            {/nocache}
            <div class="widget-header">&nbsp;
              {nocache}
                <span style="text-align: right;"><a href="groupEdit.php?appID={$appID}" class="btn btn-warning"><b>+</b>&nbsp;&nbsp;New user group</a></span>
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
                      <tr id="groupRow{$i}">
                        <td id="groupID{$i}">{$groupIDs[$i]}</td>
                        <td id="groupName{$i}" ondblclick="renameApp({$i});">{$groupNames[$i]}</td>
                        <td class="td-actions btn-group">
                          {if $groupIDs[$i] != "-"}
                            <a href="groupEdit.php?appID={$appID}&groupID={$groupIDs[$i]}" class="btn btn-small btn-success" style="margin-right: 0px;"><i class="btn-icon-only icon-pencil"> </i></a>
                            <a href="javascript:;" class="btn btn-small btn-danger" onclick="delGroup({$appID}, {$i});"><i class="btn-icon-only icon-remove"> </i></a>
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
