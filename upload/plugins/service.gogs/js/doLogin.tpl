{literal}
    var http = new XMLHttpRequest();
    var url = "{/literal}{$gogsUrl}/user/login{literal}";
    var params = "user_name=" + un + "&password=" + atob(ub);
    http.open("POST", url, true);

    //Send the proper header information along with the request
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

    http.send(params);
{/literal}
