import Foundation

class ProfileViewModel: ObservableObject {
    @Published var profile: ProfileModel?
    @Published var description = ""
    @Published var myName: String = ""
    @Published var email: String = ""
    @Published var myEmail: String = ""
    @Published var followed: Bool = false
    @Published var myPosts: [OtherPostModel] = []
    @Published var id = 0
    @Published var detailPosts: [GetDetailPost] = []
    var postExist = false
    var isLoading = false
    
    //MARK: 유저를 팔로우 or 취소합니다
    func follow(nickname: String) {
        NetworkRunner.shared.query("/follow", method: .post, parameters: ["nickname" : nickname], isAuthorization: true) { result in
            switch result {
            case .success:
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
        NetworkRunner.shared.request("/user", method: .get, parameters: ["username" : nickname], response: ProfileModel.self, isAuthorization: true) { result in
            switch result {
            case .success(let data):
                self.profile = data
                self.description = data.description ?? ""
                self.email = data.email
                self.followed = data.followed
                print("팔로우 상태: \(self.followed)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: 상대방 글
    func OtherPost(author: String) {
        guard !isLoading else { return }
        isLoading = true
        let parameters: [String: Any] = ["author": author]
        NetworkRunner.shared.request("/post/user", method: .get, parameters: parameters, response: [OtherPostModel].self) { result in
            switch result {
            case .success(let data):
                if data.isEmpty {
                    self.postExist = true
                } else {
                    self.myPosts.append(contentsOf: data)
                    self.id = data.first?.id ?? 0
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.isLoading = false
        }
    }
    
    //MARK: 상대방 자세히 보기
    func getDetailPost() {
        NetworkRunner.shared.request("/post/\(id)", response: GetDetailPost.self) { result in
            if case .success(let data) = result {
                self.detailPosts = [data]
            }
        }
    }
}
