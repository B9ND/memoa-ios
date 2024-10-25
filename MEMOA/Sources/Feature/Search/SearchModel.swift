import Foundation

struct SearchModel: Codable {
    let id: Int
    let title: String
    let author: String
    let tags: [String]
    let createdAt: String
    let images: [String]
    var getImageUrl: [URL] {
        images.compactMap { URL(string: $0) }
    }
}

struct Search {
    var recentSearch: [RecentSearches]
    var searchItem: String
}

struct RecentSearches: Hashable {
    var recentSearch: String
    
    init(recentSearch: String) {
        self.recentSearch = recentSearch
    }
}
