import Foundation

class BookmarkViewModel: ObservableObject {
    @Published var isBoomark = false
    @Published var noExist: Bool = false
    @Published var posts: [BookmarkModel] = []
    @Published var id = 0
    @Published var detailPosts: [GetDetailPost] = []
    
    func bookmark(id: Int) {
        NetworkRunner.shared.query("/bookmark", method: .post, parameters: ["post-id" : id], isAuthorization: true) { result in
            switch result {
            case .success():
                self.isBoomark.toggle()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: 북마크 가져오기
    func getBookmark() {
        NetworkRunner.shared.request("/bookmark", method: .get, response: [BookmarkModel].self, isAuthorization: true) { result in
            switch result {
            case .success(let data):
                if data.isEmpty {
                    self.noExist = true
                } else {
                    self.posts.append(contentsOf: data)
                    self.id = data.first?.postId ?? 0
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: 내 디테일 글불러오기
    func getDetailPost() {
        NetworkRunner.shared.request("/post/\(id)", response: GetDetailPost.self) { result in
            if case .success(let data) = result {
                self.detailPosts = [data]
            }
        }
    }
}
