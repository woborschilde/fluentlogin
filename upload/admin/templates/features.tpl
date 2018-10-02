{nocache}
  {include file='templates/modules/header.tpl' title='Features' ami='apps'}
{/nocache}

<script>
		{literal}
      function delFeature(a, i) {
        var r = "featureRow"+i.toString();
        var k = document.getElementById("featureID"+i.toString()).innerHTML;
        var m = document.getElementById("featureName"+i.toString()).innerHTML;

        i++;

        swal({
          title: "Really delete feature \""+m+"\"?",
          text: "All links will be removed.",
          type: "warning",
          showCancelButton: true,
          confirmButtonColor: '#d33',
          confirmButtonText: 'Yes, delete feature',
          cancelButtonText: 'Cancel',
        }).then(function () {
          xmlhttp = new XMLHttpRequest();
          xmlhttp.open("GET","functions/delFeature.php?appID="+a+"&featureID="+k,true);
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
              {include file='templates/modules/apptabs.tpl' ata='features'}
            {/nocache}
            <div class="widget-header">&nbsp;
              {nocache}
                <span style="text-align: right;"><a href="featureEdit.php?appID={$appID}" class="btn btn-secondary"><b>+</b>&nbsp;&nbsp;New feature</a></span>
              {/nocache}
            </div>
            <!-- /widget-header -->
            <div class="widget-content">
              <table class="table table-striped table-bordered">
                <thead>
                  <tr>
                    <th style="width: 40px;"> ID </th>
                    <th style="width: 20px;"> Sym. </th>
                    <th> Name </th>
                    <th class="td-actions" style="width: 7%;"> Action </th>
                  </tr>
                </thead>
                <tbody>
                  {nocache}
                    {foreach from=$keys item=i}
                      <tr id="featureRow{$i}">
                        <td id="featureID{$i}">{$featureIDs[$i]}</td>
                        <td id="featureIcon{$i}"><i class="icon-{$featureIcons[$i]}" style="color: #{$featureIconColors[$i]};"></i></td>
                        <td id="featureName{$i}">{$featureNames[$i]}</td>
                        <td class="td-actions btn-group">
                          {if $featureIDs[$i] != "-"}
                            <a href="featureEdit.php?appID={$appID}&featureID={$featureIDs[$i]}" class="btn btn-small btn-success" style="margin-right: 0px;"><i class="btn-icon-only icon-pencil"> </i></a>
                            <a href="javascript:;" class="btn btn-small btn-danger" onclick="delFeature({$appID}, {$i});"><i class="btn-icon-only icon-remove"> </i></a>
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
