{nocache}
  {include file='templates/modules/header.tpl' title='Fields' ami='apps'}
{/nocache}

<script>
		{literal}
      function delField(i) {
        var r = "fieldRow"+i.toString();
        var k = document.getElementById("fieldID"+i.toString()).innerHTML;
        var m = document.getElementById("fieldName"+i.toString()).innerHTML;

        i++;

        swal({
          title: "Really delete field \""+m+"\"?",
          text: "All links will be removed.",
          type: "warning",
          showCancelButton: true,
          confirmButtonColor: '#d33',
          confirmButtonText: 'Yes, delete field',
          cancelButtonText: 'Cancel',
        }).then(function () {
          xmlhttp = new XMLHttpRequest();
          xmlhttp.open("GET","functions/delField.php?fieldID="+k,true);
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
              {include file='templates/modules/apptabs.tpl' ata='fields'}
            {/nocache}
            <div class="widget-header">&nbsp;
              {nocache}
                <span style="text-align: right;"><a href="fieldEdit.php?appID={$appID}" class="btn btn-primary"><b>+</b>&nbsp;&nbsp;New field</a></span>
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
                      <tr id="fieldRow{$i}">
                        <td id="fieldID{$i}">{$fieldIDs[$i]}</td>
                        <td id="fieldName{$i}">{$fieldNames[$i]}</td>
                        <td class="td-actions btn-group">
                          {if $fieldIDs[$i] != "-"}
                            <a href="fieldEdit.php?appID={$appID}&fieldID={$fieldIDs[$i]}" class="btn btn-small btn-success" style="margin-right: 0px;"><i class="btn-icon-only icon-pencil"> </i></a>
                            <a href="javascript:;" class="btn btn-small btn-danger" onclick="delField({$i});"><i class="btn-icon-only icon-remove"> </i></a>
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
