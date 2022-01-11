import QtQuick 2.0
import Felgo 3.0

Page {

    id: searchPage;
    title: qsTr("Property Search")

    rightBarItem: NavigationBarRow {
        ActivityIndicatorBarItem {
            visible: true;
        }

        IconButtonBarItem {
            icon: IconType.heart
            title: qsTr("Favorites")
            onClicked: showListings(true);
        }
    }

    Column {
        id: contentCol;
        anchors.left: parent.left;
        anchors.top: parent.top;
        anchors.right: parent.right;
        anchors.margins: contentPadding;
        spacing: contentPadding;

        AppText {
            width: parent.width;
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
            font.pixelSize: sp(12);
            text: qsTr("Fill out the form below to search for properties to buy. Search by name, postalcode, or click 'My location'.");
        }

        AppText {
            width: parent.width;
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
            color: Theme.secondaryTextColor;
            font.pixelSize: sp(12);
            font.italic: true;
            text: qsTr("Hint: start by typeing something like 'New York'...");
        }

        AppTextField {
            id: searchInput;
            width: parent.width;
            showClearButton: true;
            placeholderText: qsTr("Search...");
            inputMethodHints: Qt.ImhNoPredictiveText;

            onTextChanged: showRecentSearches();
            onEditingFinished: if(navigationStack.currentPage === searchPage) {
                                   search();
                               }
        }

        Row {
            spacing: contentPadding;

            AppButton {
                text: qsTr("Go")
                onClicked: search()
            }

            AppButton {
                id: locationButton;
                text: qsTr("Get my Location");
                enabled: true;

                onClicked: {
                    searchInput.text = "";
                    searchInput.placeholderText = qsTr("Searching for location...");
                    locationButton.enabled = false;
                }
            }
        }
    }

    function showRecentSearches() {
        console.debug(searchInput.text);
    }

    function search() {
        HttpRequest.get("http://jsonplaceholder.typicode.com/posts")
        .then(function(res) {
            var content = res.text;
            try {
                console.debug(content);
                var obj = JSON.parse(content);
            }
            catch (err) {
                console.error(err);
                return;
            }
            console.debug("result parse success");
        })
        .catch(function(err) {
            console.error(err);
        })
    }

    function showListings(isFavorites) {

    }

}
