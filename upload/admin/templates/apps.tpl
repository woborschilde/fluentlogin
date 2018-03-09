{nocache}
  {include file='templates/modules/header.tpl' title='Applications' ami='apps'}
{/nocache}

<script>
		{literal}
      function delApp(i) {
        var r = "appRow"+i.toString();
        var k = document.getElementById("appID"+i.toString()).innerHTML;
        var m = document.getElementById("appName"+i.toString()).innerHTML;

        i++;

        swal({
          title: "Do you really want to delete \""+m+"\"?",
          text: "All users, user groups, fields and permissions will be removed! This process cannot be undone!",
          type: "warning",
          showCancelButton: true,
          confirmButtonColor: '#d33',
          confirmButtonText: 'Yes, delete application',
          cancelButtonText: 'Cancel',
        }).then(function () {
          xmlhttp = new XMLHttpRequest();
          xmlhttp.open("GET","functions/delApp.php?appID="+k,true);
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
            <div class="widget-header"> <i class="icon-list-alt"></i>
              <h3>Applications</h3>
              <span style="text-align: right;"><a href="appEdit.php" class="btn btn-success"><b>+</b>&nbsp;&nbsp;New application</a></span>
            </div>
            <!-- /widget-header -->
            <div class="widget-content">
              <table class="table table-striped table-bordered">
                <thead>
                  <tr>
                    <th> ID </th>
                    <th> Name </th>
                    <th class="td-actions" style="width: 28%; text-align: right;"> Action </th>
                  </tr>
                </thead>
                <tbody>
                  {nocache}
                    {foreach from=$keys item=i}
                      <tr id="appRow{$i}">
                        <td id="appID{$i}">{$appIDs[$i]}</td>
                        <td id="appName{$i}">{$appNames[$i]}</td>
                        <td class="td-actions btn-group">
                          {if $appIDs[$i] != "-"}
                            <div style="float: right;">
                              <a href="users.php?appID={$appIDs[$i]}" class="btn btn-small btn-info" style="margin-right: 0px;" data-balloon="Users" data-balloon-pos="up"><i class="btn-icon-only icon-user"> </i></a>
                              <a href="groups.php?appID={$appIDs[$i]}" class="btn btn-small btn-warning" style="margin-right: 0px;" data-balloon="User groups" data-balloon-pos="up"><i class="btn-icon-only icon-asterisk"> </i></a>
                              <a href="fields.php?appID={$appIDs[$i]}" class="btn btn-small btn-primary" style="margin-right: 0px;" data-balloon="Fields" data-balloon-pos="up"><i class="btn-icon-only icon-table"> </i></a>
                              <a href="permissions.php?appID={$appIDs[$i]}" class="btn btn-small btn-danger" style="margin-right: 0px;" data-balloon="Permissions" data-balloon-pos="up"><i class="btn-icon-only icon-legal"> </i></a>
                              <a href="services.php?appID={$appIDs[$i]}" class="btn btn-small btn-violet" style="margin-right: 5px;" data-balloon="Services" data-balloon-pos="up"><i class="btn-icon-only icon-link"> </i></a>
                              <a href="appEdit.php?appID={$appIDs[$i]}" class="btn btn-small btn-success" style="margin-right: 0px;" data-balloon="Edit" data-balloon-pos="up"><i class="btn-icon-only icon-pencil"> </i></a>
                              <a href="javascript:;" class="btn btn-small btn-danger" onclick="delApp({$i});" style="margin-right: 0px;" data-balloon="Delete" data-balloon-pos="up"><i class="btn-icon-only icon-remove"> </i></a>
                              <a href="../index.php?appID={$appIDs[$i]}" target="_blank" class="btn btn-small btn-primary" style="margin-right: 0px;" data-balloon="App Page" data-balloon-pos="up"><i class="btn-icon-only icon-arrow-right"> </i></a>
                            </div>
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
