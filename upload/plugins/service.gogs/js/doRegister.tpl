{literal}
    var http = new XMLHttpRequest();
    var url = "{/literal}{$gogsUrl}{literal}/user/sign_up";
    var params = "user_name=" + un + "&password=" + atob(ub) + "&retype=" + atob(ub) + "&email=" + ue;

    http.onreadystatechange = function() {
        if (this.readyState == 4) {
            if (this.response.documentElement.outerHTML.includes("ui negative message")) {
                document.getElementById("login-finish").innerHTML += "<hr /><b style='color: #f27474;'>Registration error on {/literal}{$sn}{literal}</b><br />" + this.response.getElementsByClassName("ui negative message")[0].innerHTML + "<br /><span style='font-size: 10px'>It's very likely that you have to manually re-register for this service.</span>";
            }
       }
    };

    http.open("POST", url, true);

    //Send the proper header information along with the request
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.responseType = "document";

    http.send(params);
{/literal}
