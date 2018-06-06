{literal}
    var http = new XMLHttpRequest();
    var url = "{/literal}{$seafileLoginUrl}{literal}";
    var params = "login=" + ue + "&password=" + atob(ub) + "&csrfmiddlewaretoken="+readCookie("csrftoken");
    http.open("POST", url, true);

    //Send the proper header information along with the request
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

    http.send(params);
{/literal}
