import Foundation

class ProfileViewModel: ObservableObject {
    @Published var description = ""
    @Published var name: String = ""
    @Published var isFollow: Bool = false {
        didSet {
            saveFollowState()
        }
    }
    
    //상태 로드
    init() {
        loadFollowState()
    }
    
    //MARK: 팔로우
    func follow(nickname: String) {
        NetworkRunner.shared.follow("/follow", method: .post, parameters: ["follower" : nickname], isAuthorization: true) { result in
            switch result {
            case .success(_):
                self.isFollow = true
                self.saveFollowState()
                print("팔로우")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: 언팔
    func deleteFollow(nickname: String) {
        NetworkRunner.shared.follow("/follow", method: .delete, parameters: ["follower" : nickname], isAuthorization: true) { result in
            switch result {
            case .success(_):
                self.isFollow = false
                self.saveFollowState()
                print("언팔로우")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func saveFollowState() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(isFollow, forKey: "isFollow")
    }
    
    //상태 로드
    private func loadFollowState() {
        let userDefaults = UserDefaults.standard
        isFollow = userDefaults.bool(forKey: "isFollow")
    }
    
    //MARK: 내정보로 팔로우 할수있게
    func fetchMy() {
        NetworkRunner.shared.request("/auth/me", method: .get, response: MyProfileModel.self, isAuthorization: true) { result in
            switch result {
            case .success(let data):
                self.name = data.nickname
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getUser(nickname: String) {
        NetworkRunner.shared.request("/auth/user", method: .get, parameters: ["username" : nickname], response: MyProfileModel.self) { result in
            switch result {
            case .success(let data):
                self.description = data.description ?? ""
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
