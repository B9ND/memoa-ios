import Foundation
import Alamofire

class MyProfileViewModel: ObservableObject {
    @Published var name: String = "박재민"
    @Published var email: String = "pjmin0923@gmail.com"
    let serverUrl = ServerUrl.shared
    
    private var refreshToken: String {
        return UserDefaults.standard.string(forKey: "refresh") ?? ""
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
//        
//        NetworkRunner.shared.request("/auth/logout", method: .delete, parameters: nil, response: <#T##Decodable.Type#>) { <#Result<Decodable, any Error>#> in
//            <#code#>
//        }
    }
}
