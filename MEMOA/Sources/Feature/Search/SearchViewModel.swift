import SwiftUI

//MARK: 최근검색어
class SearchViewModel: ObservableObject {
    @Published var searchItem: String = ""
    @Published var recentSearchesList: [RecentSearches]
    
    init() {
        self.recentSearchesList = []
    }
    // 최근검색어
    func addSearchItem() {
        let newSearch = RecentSearches(recentSearch: searchItem)
        
        if !newSearch.recentSearch.isEmpty{
            recentSearchesList.append(newSearch)
            searchItem = ""
        }
        if recentSearchesList.count > 6 {
            recentSearchesList.remove(at: 0)
        }
    }
    
    // 검색어 지우기
    func clearSearches() {
        recentSearchesList.removeAll()
    }
    
    // 유저디폴트
    func saveSearches() {
        let searches = recentSearchesList.map { $0.recentSearch }
        UserDefaults.standard.set(searches, forKey: "recentSearches")
    }
    
    // 유저디폴트
    func loadSearches() {
        if let savedSearches = UserDefaults.standard.array(forKey: "recentSearches") as? [String] {
            self.recentSearchesList = savedSearches.map { RecentSearches(recentSearch: $0 )}
        }
    }
}
