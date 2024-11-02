import Foundation
import Alamofire

class MyProfileViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var description: String = ""
    let serverUrl = ServerUrl.shared
    
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
}
