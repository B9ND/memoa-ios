import Foundation

struct SearchModel {
    var RecentSearch: [RecentSearches]
    var searchitem: String = ""
}

struct RecentSearches: Hashable {
    var RecentSearch: String
    
    init(RecentSearch: String) {
        self.RecentSearch = RecentSearch
    }
}
