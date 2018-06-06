{literal}
    var http = new XMLHttpRequest();
    var url = "{/literal}{$seafileUrl}/accounts/logout/{literal}";
    http.open("GET", url, true);

    http.send(null);
{/literal}
