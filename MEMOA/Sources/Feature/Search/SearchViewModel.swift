import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var searchItem: String = ""
    @Published var recentSearcheslist: [RecentSearches]
    
    init() {
        self.recentSearcheslist = []
    }
    
    func addSearchItem() {
        let newSearch = RecentSearches(RecentSearch: searchItem)
        
        if !newSearch.RecentSearch.isEmpty{
            recentSearcheslist.append(newSearch)
            searchItem = ""
        }
        if recentSearcheslist.count > 6 {
            recentSearcheslist.remove(at: 0)
        }
    }
    
    func clearSearches() {
        recentSearcheslist.removeAll()
    }
    
    func saveSearches() {
        let searches = recentSearcheslist.map { $0.RecentSearch }
        UserDefaults.standard.set(searches, forKey: "recentSearches")
    }
    
    func loadSearches() {
        if let savedSearches = UserDefaults.standard.array(forKey: "recentSearches") as? [String] {
            self.recentSearcheslist = savedSearches.map { RecentSearches(RecentSearch: $0 )}
        }
    }
}
