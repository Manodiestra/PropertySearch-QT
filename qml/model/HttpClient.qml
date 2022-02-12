import QtQuick 2.0
import Felgo 3.0
// import QSslSocket 1.0

Item {

    readonly property bool loadingHttpData: HttpNetworkActivityIndicator.enabled;

    Component.onCompleted: {
        HttpNetworkActivityIndicator.activationDelay = 0;
    }

    Item {
        id: _;
        readonly property string serverUrl: "http://jsonplaceholder.typicode.com/posts";
        property var prevParams: ({});

        function buildUrl (params) {
            var thisUrl = serverUrl;
            for (var param in params) {
                thisUrl += "&" + param + "=" + params[param];
            }
            return thisUrl;
        }

        function sendRequest (params, callback) {
            var method = "GET";
            var url = buildUrl(params);
            console.debug("Method:" + method + " URL: " + url);

            // supportsSsl()

            HttpRequest.get(url)
            .then(function(res) {
                var content = res.text;
                try {
                    var obj = JSON.parse(content);
                }
                catch(err) {
                    console.error(err);
                    return;
                }
                console.debug("Parse success", obj[0]);
                callback(obj);
            })
            .catch(function(err) {
                console.error(err);
            })

            prevParams = params;
        }
    }

    function search(text, callback) {
        _.sendRequest({}, callback);
    }

    function searchByLocation(lat, lon, callback) {
        _.sendRequest({}, callback);
    }

    function repeatForPage (page, callback) {
        var thisParams = prevParams;
        params.page = page;
        _.sendRequest(params, callback);
    }
}
