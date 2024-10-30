import Foundation
import Alamofire

class GetPostViewModel: ObservableObject {
    let serverUrl = ServerUrl.shared
    
    //MARK: getPostModel
    @Published var posts: [GetPostModel] = []
    var page = 0
    var isLoading = false
    var canLoadMore = true
    
    //MARK: getDetailModel
    @Published var id = 0
    @Published var detailPosts: [GetDetailPost] = []
    
    
    private var token: String {
        return UserDefaults.standard.string(forKey: "access") ?? ""
    }
    
    
    //MARK: 게시글 불러오기
    func loadPost() {
        guard !isLoading, canLoadMore else { return }
        isLoading = true
        let url = serverUrl.getUrl(for: "/post")
        
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
                        self.id = data.first?.id ?? 0
                    }
                case .failure(let error):
                    if let httpResponse = response.response, httpResponse.statusCode == 403 {
                        RefreshAccessToken.shared.reissue { success in
                            if success {
                                self.loadPost()
                            } else {
                                print("토큰 재발급 실패")
                            }
                        }
                    } else {
                        print(error.localizedDescription)
                    }
                }
                self.isLoading = false
            }
    }
    
    //MARK: 아이디로 받아옴 게시물 자세히 보기
    func getDetailPost() {
        let url = serverUrl.getUrl(for: "/post/\(id)")
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
        ]
        
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: GetDetailPost.self) { response in
                switch response.result {
                case .success(let data):
                    self.detailPosts = [data]
                    print(data)
                case .failure(let error):
                    if let httpResponse = response.response, httpResponse.statusCode == 403 {
                        RefreshAccessToken.shared.reissue { success in
                            if success {
                                self.getDetailPost()
                            } else {
                                print("토큰 재발급 실패")
                            }
                        }
                    } else {
                        print(error.localizedDescription)
                    }
                }
            }
    }
}
