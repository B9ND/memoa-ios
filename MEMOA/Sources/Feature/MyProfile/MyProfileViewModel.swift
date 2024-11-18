import Foundation
import Alamofire

class MyProfileViewModel: ObservableObject {
    @Published var profile: MyProfileModel?
    
    @Published var myPosts: [MyPostModel] = []
    var canLoadMore = true
    
    @Published var id = 0
    @Published var detailPosts: [GetDetailPost] = []
    
    private var refreshToken: String {
        return UserDefaults.standard.string(forKey: "refresh") ?? ""
    }
    
    //MARK: 내정보 불러오기
    func fetchMy() {
        NetworkRunner.shared.request("/auth/me", method: .get, response: MyProfileModel.self, isAuthorization: true) { result in
            switch result {
            case .success(let data):
                self.profile = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    //MARK: 로그아웃
    func delete() {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(refreshToken)"
        ]
        
        NetworkRunner.shared.request("/auth/logout", method: .delete, headers: headers) { result in
            switch result {
            case .success(_):
                UserDefaults.setValue("access", forKey: "")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: 내 글불러오기
    func fetchMyPost(author: String) {
        let parameters: [String: Any] = ["author": author]
        NetworkRunner.shared.request("/post/user", method: .get, parameters: parameters, response: [MyPostModel].self) { result in
            switch result {
            case .success(let data):
                if data.isEmpty {
                    self.canLoadMore = false
                } else {
                    self.myPosts.append(contentsOf: data)
                    self.id = data.first?.id ?? 0
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
