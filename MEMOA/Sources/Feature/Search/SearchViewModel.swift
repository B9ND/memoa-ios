import SwiftUI
import Alamofire

//MARK: 최근검색어
class SearchViewModel: ObservableObject {
    //최근검색어
    @Published var searchItem: String = ""
    @Published var recentSearchesList: [RecentSearches]
    
    //검색 목록
    @Published var posts: [SearchModel] = []
    @Published var id = 0
    var noLoading = false
    let serverUrl = ServerUrl.shared
    
    let tokenUrl = TokenUrl.shared
    
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
    
    func getPost() {
        let url = serverUrl.getUrl(for: "/post")
        
        let token = tokenUrl.token
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
        ]
        
        
        let parameters: [String: Any] = [
            "search": "",
            "tags": [
                searchItem
            ],
            "page": 1,
            "size": 10
        ]
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [SearchModel].self) { response in
                switch response.result {
                case .success(let data):
                    if data.isEmpty {
                        self.noLoading = true
                    } else {
                        self.posts = data
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
