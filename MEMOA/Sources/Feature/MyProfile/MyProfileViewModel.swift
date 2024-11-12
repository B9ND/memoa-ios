import Foundation
import Alamofire

class MyProfileViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var description: String = ""
    @Published var profileImage: String = ""
    @Published var subjects: [String] = []
    //TODO: 서브젝트 불러와서 글쓰기 할때 불러오기
    let serverUrl = ServerUrl.shared
    
    @Published var myPosts: [MyPostModel] = []
    var canLoadMore = true
    
    @Published var id = 0
    @Published var detailPosts: [GetDetailPost] = []
    
    private var refreshToken: String {
        return UserDefaults.standard.string(forKey: "refresh") ?? ""
    }
    
    //MARK: 내정보 불러오기
    func fetchMy(followerVM: FollowerViewModel, followingVM: FollowingViewModel) {
        NetworkRunner.shared.request("/auth/me", method: .get, response: MyProfileModel.self, isAuthorization: true) { result in
            switch result {
            case .success(let data):
                self.name = data.nickname
                self.email = data.email
                self.description = data.description ?? "설명이 없습니다."
                self.profileImage = data.profileImage
                self.subjects = data.department.subjects
                followerVM.getFollower(nickname: self.name)
                followingVM.getFollowing(nickname: self.name)
                self.fetchMyPost(author: self.name)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    //MARK: 로그아웃
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
