import QtQuick 2.0
import Felgo 3.0
import QSslSocket 1.0

Item {

    readonly property bool loadingHttpData: HttpNetworkActivityIndicator.enabled;

    Component.onCompleted: {
        HttpNetworkActivityIndicator.activationDelay = 0;
    }

    Item {
        id: _;
        readonly property string serverUrl: "http://api.nestoria.co.uk/api?country=us&pretty=1&encoding=json&listing_type=buy";
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

            supportsSsl()

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
                console.debug("Parse success")
            })
            .catch(function(err) {
                console.error(err);
            })

            prevParams = params;
        }
    }

    function search(text, callback) {
        _.sendRequest({
            action: "search_listings",
            page: 1,
            place_name: text
        }, callback);
    }

    function searchByLocation(lat, lon, callback) {
        _.sendRequest({
            action: "search_listings",
            page: 1,
            centre_point: lat + "," + lon
        }, callback);
    }

    function repeatForPage (page, callback) {
        var thisParams = prevParams;
        params.page = page;
        _.sendRequest(params, callback);
    }
}
