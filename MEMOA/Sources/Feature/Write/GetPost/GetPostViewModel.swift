import Foundation
import Alamofire

class GetPostViewModel: ObservableObject {
    
    //MARK: getPostModel
    @Published var posts: [GetPostModel] = []
    var page = 0
    var isLoading = false
    var canLoadMore = true
    
    //MARK: getDetailModel
    @Published var id = 0
    @Published var detailPosts: [GetDetailPost] = []
    @Published var tags: [String] = []
    
    
    //MARK: 게시글 불러오기
    func loadPost() {
        guard !isLoading, canLoadMore else { return }
        isLoading = true
        
        let parameters: [String: Any] = [
            "search": "",
            "tags": tags,
            "page": page,
            "size": 10
        ]

        NetworkRunner.shared.request("/post", method: .get, parameters: parameters, response: [GetPostModel].self) { result in
            switch result {
            case .success(let data):
                if data.isEmpty {
                    self.canLoadMore = false
                } else {
                    self.posts.append(contentsOf: data)
                    self.id = data.first?.id ?? 0
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.isLoading = false
        }
        
    }
    
    //MARK: 아이디로 받아옴 게시물 자세히 보기
    func getDetailPost() {
        NetworkRunner.shared.request("/post/\(id)", response: GetDetailPost.self) { result in
            if case .success(let data) = result {
                self.detailPosts = [data]
            }
        }
    }
}
