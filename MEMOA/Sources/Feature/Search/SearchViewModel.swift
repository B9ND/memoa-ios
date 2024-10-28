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
    
    var page = 0
    
    //MARK: 검색어 목록없음
    var noPost = false
    
    //MARK: 게시글 로딩
    var isLoading = false
    
    //MARK: 더이상 로드할 게시물 x
    var canLoadMore = true
    
    //MARK: 서버url
    let serverUrl = ServerUrl.shared
    
    //MARK: 임시
    let tokenUrl = TokenUrl.shared
    
    init() {
        self.recentSearchesList = []
    }
    // 최근검색어
    func addSearchItem() {
        let newSearch = RecentSearches(recentSearch: searchItem)
        
        if !newSearch.recentSearch.isEmpty {
            recentSearchesList.insert(newSearch, at: 0)
        }
        if recentSearchesList.count > 6 {
            recentSearchesList.remove(at: 0)
        }
    }
    
    // 검색어 지우기
    func clearSearches() {
        recentSearchesList.removeAll()
    }
    
    // 유저디폴트로 저장
    func saveSearches() {
        let searches = recentSearchesList.map { $0.recentSearch }
        UserDefaults.standard.set(searches, forKey: "recentSearches")
    }
    
    // 유저디폴트로 저장
    func loadSearches() {
        if let savedSearches = UserDefaults.standard.array(forKey: "recentSearches") as? [String] {
            self.recentSearchesList = savedSearches.map { RecentSearches(recentSearch: $0 )}
        }
    }
    func getPost() {
        //MARK: 새로운 검색어로 검색할 때 초기화
        if searchItem.isEmpty {
            self.noPost = true
            self.canLoadMore = false
            return
        }
        
        //MARK: 페이지를 0으로 초기화
        if page == 0 {
            self.posts.removeAll()
            self.canLoadMore = true
        }
        
        let url = serverUrl.getUrl(for: "/post")
        let token = tokenUrl.token
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
        ]
        
        let parameters: [String: Any] = [
            "search": searchItem,
            "tags": [
                "기타"
            ],
            "page": page,
            "size": 10
        ]
        
        isLoading = true
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [SearchModel].self) { response in
                switch response.result {
                case .success(let data):
                    if data.isEmpty {
                        self.noPost = true
                        self.canLoadMore = false
                    } else {
                        self.noPost = false
                        self.posts.append(contentsOf: data)
                        self.page += 1
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self.isLoading = false
            }
    }
    
}

