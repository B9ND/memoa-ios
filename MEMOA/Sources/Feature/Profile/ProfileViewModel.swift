import Foundation

class ProfileViewModel: ObservableObject {
    @Published var description = ""
    @Published var myName: String = ""
    @Published var email: String = ""
    @Published var myEmail: String = ""
    @Published var followed: Bool = false
    
    //MARK: 유저를 팔로우 or 취소합니다
    func follow(nickname: String) {
        NetworkRunner.shared.follow("/follow", method: .post, parameters: ["nickname" : nickname], isAuthorization: true) { result in
            switch result {
            case .success(_):
                print("팔로우됨")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: 내정보로 팔로우 할수있게
    func fetchMy() {
        NetworkRunner.shared.request("/auth/me", method: .get, response: MyProfileModel.self, isAuthorization: true) { result in
            switch result {
            case .success(let data):
                self.myName = data.nickname
                self.myEmail = data.email
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: 유저의 정보 불러오기
    func getUser(nickname: String) {
        NetworkRunner.shared.request("/user", method: .get, parameters: ["username" : nickname], response: MyProfileModel.self, isAuthorization: true) { result in
            switch result {
            case .success(let data):
                self.description = data.description ?? ""
                self.email = data.email
                self.followed = data.followed
                print("팔로우 상태: \(self.followed)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
