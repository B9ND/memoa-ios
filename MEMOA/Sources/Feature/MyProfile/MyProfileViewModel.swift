import Foundation
import Alamofire

class MyProfileViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var description: String = ""
    let serverUrl = ServerUrl.shared
    
    @Published var myPosts: [MyPostModel] = []
    var canLoadMore = true
    
    @Published var id = 0
    @Published var detailPosts: [GetDetailPost] = []
    
    private var refreshToken: String {
        return UserDefaults.standard.string(forKey: "refresh") ?? ""
    }
    
    func fetchMy(followerVM: FollowerViewModel, followingVM: FollowingViewModel) {
        NetworkRunner.shared.request("/auth/me", method: .get, response: MyProfileModel.self, isAuthorization: true) { result in
            switch result {
            case .success(let data):
                self.name = data.nickname
                self.email = data.email
                self.description = data.description ?? "설명이 없습니다."
                followerVM.getFollower(user: self.name)
                followingVM.getFollowing(user: self.name)
                self.fetchMyPost(author: self.name)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func delete() {
        let url = serverUrl.getUrl(for: "/auth/logout")
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(refreshToken)"
        ]
        
        AF.request(url, method: .delete, headers: headers)
            .response { reponse in
                switch reponse.result {
                case .success(_):
                    print("로그아웃됨")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
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
    
    func getDetailPost() {
        NetworkRunner.shared.request("/post/\(id)", response: GetDetailPost.self) { result in
            if case .success(let data) = result {
                self.detailPosts = [data]
            }
        }
    }
}
