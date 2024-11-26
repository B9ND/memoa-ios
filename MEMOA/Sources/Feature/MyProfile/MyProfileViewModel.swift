import Foundation
import Alamofire

class MyProfileViewModel: ObservableObject {
    @Published var profile: MyProfileModel?
    @Published var myPosts: [MyPostModel] = []
    
    var postExist = false
    var isLoading = false
    
    @Published var id = 0
    @Published var detailPosts: [GetDetailPost] = []
    
    private var refreshToken: String {
        return UserDefaults.standard.string(forKey: "refresh") ?? ""
    }
    
<<<<<<< HEAD
=======
//    init() {
//        fetchMy()
//        //MARK: 이거 처음에 로그인했을때 안불러와짐 수정해야함
//    }으믕으므으으으으 ㅇ
>>>>>>> develop
    
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
        let parameters = [
            "refresh": "\(refreshToken)"
        ]
        NetworkRunner.shared.request("/auth/logout", method: .delete, parameters: parameters) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: 내 글불러오기
    func fetchMyPost(author: String) {
        guard !isLoading else { return }
        isLoading = true
        let parameters: [String: Any] = ["author": author]
        NetworkRunner.shared.request("/post/user", method: .get, parameters: parameters, response: [MyPostModel].self) { result in
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
    
    //MARK: 내 디테일 글불러오기
    func getDetailPost() {
        NetworkRunner.shared.request("/post/\(id)", response: GetDetailPost.self) { result in
            if case .success(let data) = result {
                self.detailPosts = [data]
            }
        }
    }
}
