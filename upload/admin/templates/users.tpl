{nocache}
  {include file='templates/modules/header.tpl' title='Users' ami='apps'}
{/nocache}

<script>
		{literal}
      function delUser(a, i) {
        var r = "userRow"+i.toString();
        var k = document.getElementById("userID"+i.toString()).innerHTML;
        var m = document.getElementById("userName"+i.toString()).innerHTML;

        i++;

        swal({
          title: "Really delete user \""+m+"\"?",
          text: "All links will be removed.",
          type: "warning",
          showCancelButton: true,
          confirmButtonColor: '#d33',
          confirmButtonText: 'Yes, delete user',
          cancelButtonText: 'Cancel',
        }).then(function () {
          xmlhttp = new XMLHttpRequest();
          xmlhttp.open("GET","functions/delUser.php?appID="+a+"&userID="+k,true);
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
          {nocache}
            {include file='templates/modules/apptabs.tpl' ata='users'}
          {/nocache}
          <div class="widget widget-table action-table">
            <div class="widget-header">&nbsp;
              {nocache}
                <span style="text-align: right;"><a href="userEdit.php?appID={$appID}" class="btn btn-info"><b>+</b>&nbsp;&nbsp;New user</a></span>
                {foreach from=$plugins_hook_users_titlebuttons item=k}
                  {include file='../../plugins/'|cat:$k|cat:'/admin/templates/hook_users_titlebuttons.tpl'}
                {/foreach}
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
                      <tr id="userRow{$i}">
                        <td id="userID{$i}">{$userIDs[$i]}</td>
                        <td id="userName{$i}" ondblclick="renameApp({$i});">{$userNames[$i]}</td>
                        <td class="td-actions btn-group">
                          {if $userIDs[$i] != "-"}
                            <a href="userEdit.php?appID={$appID}&userID={$userIDs[$i]}" class="btn btn-small btn-success" style="margin-right: 0px;"><i class="btn-icon-only icon-pencil"> </i></a>
                            <a href="javascript:;" class="btn btn-small btn-danger" onclick="delUser({$appID}, {$i});"><i class="btn-icon-only icon-remove"> </i></a>
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
