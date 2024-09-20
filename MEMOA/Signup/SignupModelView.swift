import Foundation
import Alamofire

class SignupModelView: ObservableObject {
    @Published var email: String = ""
    @Published var code : String = ""
    @Published var password: String = ""
    @Published var nickname: String = ""
    
    @Published var isSecure: Bool = true
    
    @Published var signuperrorMessage: String? = nil
    
    var isSignupDisabled: Bool {
        email.isEmpty || password.isEmpty || nickname.isEmpty
    }
    
    func Signup() {
        let url = "http://15.165.18.151/auth/register"
        
        AF.request(
            url,
            method: .post,
            parameters: SignupModel(
                email: email,
                password: password,
                nickname: nickname
            ),
            encoder: JSONParameterEncoder.default
        )
        .validate(statusCode: 200..<300)
        .response { response in
            switch response.result {
            case .success(let result):
                print("성공")
                self.signuperrorMessage = nil
            case .failure(let error):
                print("실패: \(error.localizedDescription)")
                self.signuperrorMessage = "예상치 못한 오류가 발생했습니다."
            }
        }
        
    }
}
