{literal}
    var http = new XMLHttpRequest();
    var url = "{/literal}{$seafileUrl}{literal}/accounts/register/";
    var params = "&password1=" + atob(ub) + "&password2=" + atob(ub) + "&email=" + ue + "&csrfmiddlewaretoken="+readCookie("csrftoken");

    http.onreadystatechange = function() {
        if (this.readyState == 4) {
            if (this.response.documentElement.outerHTML.includes("errorlist")) {
                document.getElementById("login-finish").innerHTML += "<hr /><b style='color: #f27474;'>Registration error on {/literal}{$sn}{literal}</b><br />" + this.response.getElementsByClassName("errorlist")[0].innerHTML + "<br /><span style='font-size: 10px'>It's very likely that you have to manually re-register for this service.</span>";
            }
       }
    };

    http.open("POST", url, true);

    //Send the proper header information along with the request
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.responseType = "document";

    http.send(params);
{/literal}
