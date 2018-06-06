{literal}
    var http = new XMLHttpRequest();
    var url = "{/literal}{$gogsUrl}/user/logout{literal}";
    http.open("GET", url, true);

    http.send(null);
{/literal}
