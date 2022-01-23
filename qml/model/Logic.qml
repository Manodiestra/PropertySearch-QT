import QtQuick 2.0
import Felgo 3.0

Item {

    // These signals MUST be named with camelCase
    // for the dispatcher to be able to call their
    // corresponding "on" events.
    // Example:
    // useLocation fires onUseLocation.

    signal useLocation()

    signal searchListings (string searchText, bool addToTecents);

    signal showRecentSearches()

    signal loadNextPage()

    signal toggleFavorite (var listingData);

}
