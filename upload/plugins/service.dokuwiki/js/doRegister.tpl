{literal}
    var http = new XMLHttpRequest();
    var url = "{/literal}{$dokuwikiUrl}{literal}/de/start?do=register";
    var params = "do=register&save=1&login=" + un + "&pass=" + atob(ub) + "&passchk=" + atob(ub) + "&fullname=" + un + "&email=" + ue;

    http.onreadystatechange = function() {
        if (this.readyState == 4) {
            if (this.response.documentElement.outerHTML.includes("error")) {
                document.getElementById("login-finish").innerHTML += "<hr /><b style='color: #f27474;'>Registration error on {/literal}{$sn}{literal}</b><br />" + this.response.getElementsByClassName("error")[0].innerHTML + "<br /><span style='font-size: 10px'>It's very likely that you have to manually re-register for this service.</span>";
            }
       }
    };

   /* http.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            if (this.response.documentElement.outerHTML.includes("error")) {
                if (this.response.getElementsByClassName("error")[0].innerHTML.includes("CAPTCHA")) {
                    swal({
                        type: "info",
                        title: "CAPTCHA ausfüllen für " + serviceName,
                        html: this.response.getElementById("plugin__captcha_wrapper").children[2],
                        input: "text",
				        allowOutsideClick: false,
                        allowEscapeKey: false,
                        inputValidator: function(value) {
                            return new Promise(function (resolve, reject) {
                                http.onreadystatechange = function() {
                                    if (this.readyState == 4 && this.status == 200) {
                                        if (this.response.documentElement.outerHTML.includes("error")) {
                                            if (this.response.getElementsByClassName("error")[0].innerHTML.includes("CAPTCHA")) {
                                                reject("Sie haben nicht die korrekten Zeichen eingegeben!");
                                            }
                                        } else {
                                            resolve();
                                        }
                                    }
                                }
                                http.open("POST", url, true);
                                http.send(params);
                            });
                        },
                    });
                } else {
                    swal({
                        type: "error",
                        title: "Fehler bei der Registrierung in " + serviceName,
                        html: this.response.getElementsByClassName("error")[0].innerHTML + "<br /><br />Sie werden sich für diesen Dienst wahrscheinlich über die Einzelregistrierung erneut eintragen müssen."
                    });
                }
            }
       }
    }; */

    http.open("POST", url, true);

    //Send the proper header information along with the request
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.responseType = "document";

    http.send(params);
{/literal}
