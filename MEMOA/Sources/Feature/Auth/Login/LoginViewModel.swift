import Foundation
import Alamofire

class LoginModelView: ObservableObject {
    @Published var request: LoginModel = .init()
    @Published var email: String = ""
    @Published var password: String = ""

    @Published var isSecure: Bool = true
    @Published var loginerrorMessage: String?  // 에러 메시지 저장
    let serverUrl = ServerUrl.shared

    var isLoginDisabled: Bool {
        email.isEmpty || password.isEmpty
    }
    
    // async 함수로 변경하여 서버 통신 후 결과를 리턴
    func login() async -> Bool {
        let url = serverUrl.getUrl(for: "/auth/login")
        
        // AF.request를 Task로 감싸서 await로 처리
        return await withCheckedContinuation { continuation in
            AF.request(
                url,
                method: .post,
                parameters: LoginModel(email: email, password: password),
                encoder: JSONParameterEncoder.default
            )
            .validate(statusCode: 200..<300)  // 성공 범위 200~299
            .response { response in
                switch response.result {
                case .success:
                    // 로그인 성공 시 true 리턴
                    continuation.resume(returning: true)
                case .failure(let error):
                    // 에러 처리
                    self.loginerrorMessage = error.localizedDescription
                    continuation.resume(returning: false)  // 실패 시 false 리턴
                }
            }
        }
    }
}
