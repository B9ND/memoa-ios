import Foundation
import Alamofire

class GetPostViewModel: ObservableObject {
    let serverUrl = ServerUrl.shared
    
    //MARK: getPostModel
    @Published var posts: [GetPostModel] = []
    var page = 0
    var isLoading = false
    var canLoadMore = true
    
    //MARK: 게시글 불러오기
    func post() {
        guard !isLoading, canLoadMore else { return }
        isLoading = true
        let url = serverUrl.getUrl(for: "/post")
        
        let token = "eyJhbGciOiJIUzI1NiJ9.eyJjYXRlZ29yeSI6ImFjY2VzcyIsImVtYWlsIjoia2ltZXVuY2hhbjI4MTVAZ21haWwuY29tIiwicm9sZSI6IlJPTEVfVVNFUiIsImRldmljZSI6Ik1vemlsbGEvNS4wIChNYWNpbnRvc2g7IEludGVsIE1hYyBPUyBYIDEwXzE1XzcpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMjguMC4wLjAgU2FmYXJpLzUzNy4zNl8yMjEuMTY4LjIyLjIwNSIsImlhdCI6MTcyOTczMzYwOSwiZXhwIjoxNzI5NzM0MjA5fQ.uRjR4k5g-d6l4MVU8LfqyPPQG2WR4TLlLXy9eQg_4D0"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
        ]
        
        
        let parameters: [String: Any] = [
            "search": "",
            "tags": [
                "기타", "수학", "사회", "과학", "국어", "영어"
            ],
            "page": page,
            "size": 10
        ]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [GetPostModel].self) { response in
                switch response.result {
                case .success(let data):
                    if data.isEmpty {
                        self.canLoadMore = false
                    } else {
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
