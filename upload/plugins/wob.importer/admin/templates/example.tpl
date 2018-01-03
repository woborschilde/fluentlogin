<script>
	{literal}
    function rename(new_name) {
        xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function() {
          if (this.readyState == 4 && this.status == 200) {
            if (this.responseText == "1") {
              swal({
                type: "success",
                title: "Saved",
                text: "Your are now called " + new_name + "."
              });
              setTimeout(function(){
                location.reload();
              }, 1000);
            } else {
              swal({
                type: "error",
                title: "Couldn't save your stuff",
                text: this.responseText
              });
            }
          }
        }
        xmlhttp.open("GET","functions/plugin.php?plugin=wob.importer&action=rename&name="+new_name, true);
        xmlhttp.send();
      }
    {/literal}
</script>

<b>Hello {$myVariable}!</b><br />
<a href="javascript:;" onclick="rename('John');">Call me John!</a><br />
<a href="javascript:;" onclick="rename('Paul');">Call me Paul!</a>
