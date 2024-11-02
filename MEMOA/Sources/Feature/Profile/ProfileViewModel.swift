import Foundation

class ProfileViewModel: ObservableObject {
    
    func follow(nickname: String) {
        NetworkRunner.shared.follow("/follow", method: .post, parameters: nickname, isAuthorization: true) { result in
            switch result {
            case .success(_):
                print("팔로우")
            case .failure(_):
                break
            }
        }
    }
    
    func deleteFollow(nickname: String) {
        NetworkRunner.shared.follow("/follow", method: .delete, parameters: nickname, isAuthorization: true) { result in
            switch result {
            case .success(_):
                print("언팔로우")
            case .failure(_):
                break
            }
        }
    }
}
