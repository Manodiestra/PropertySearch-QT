import QtQuick 2.0
import Felgo 3.0

Item {

    property alias dispatcher: logicConnection.target;

    HttpClient {
        id: httpClient;
    }

    Connections {
        id: logicConnection;

        onSearchListings: {  // "on"SearchListings is a required naming convention
            httpClient.search(searchText, _.responseCallback)
        }
    }

    Item {
        id:_

        function responseCallback (obj) {
            var response = obj.response;
            console.debug("Debug:");
        }
    }

}
