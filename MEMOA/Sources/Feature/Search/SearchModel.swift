import Foundation

struct SearchModel {
    var recentSearch: [RecentSearches]
    var searchItem: String = ""
}

struct RecentSearches: Hashable {
    var recentSearch: String
    
    init(recentSearch: String) {
        self.recentSearch = recentSearch
    }
}
