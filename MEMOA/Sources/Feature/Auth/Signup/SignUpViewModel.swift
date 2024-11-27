import Foundation
import Alamofire

class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var code: String = ""
    @Published var password: String = ""
    @Published var nickname: String = ""
    @Published var departmentId: Int?
    
    let serverUrl = ServerUrl.shared
    @Published var isSecure: Bool = true
    @Published var signupErrorMessage: String? = nil
    @Published var isTimerRunning: Bool = false
    @Published var remainingTime: Int = 0
    
    // 타이머 시작
    func startCountdown() {
        remainingTime = 300
        isTimerRunning = true
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            DispatchQueue.main.async {
                if self.remainingTime > 0 {
                    self.remainingTime -= 1
                } else {
                    timer.invalidate()
                    self.isTimerRunning = false
                }
            }
        }
    }
    
    var isSignupDisabled: Bool {
        email.isEmpty || password.isEmpty || nickname.isEmpty || departmentId == nil
    }
    
    // 비동기 회원가입 함수
    func signup() async -> Bool {
        
        return await withCheckedContinuation { continuation in
            NetworkRunner.shared.request("/auth/signup", method: .post, parameters: SignupModel(
                email: email,
                password: password,
                nickname: nickname,
                departmentId: departmentId
            ), response: SignupResponse.self) { result in
                switch result {
                case .success(let responseData):
                    print("회원가입 성공: \(responseData)")
                    self.signupErrorMessage = "예상치 못한 오류가 발생했습니다."
                    continuation.resume(returning: false)
                case .failure(let error):
                    print("회원가입 실패: \(error)")
                    self.signupErrorMessage = "예상치 못한 오류가 발생했습니다."
                    continuation.resume(returning: false)
                }
            }

        }
    }
// 확인하고 지우자
//    AF.request(
//                   url,
//                   method: .post,
//                   parameters: SignupModel(
//                       email: email,
//                       password: password,
//                       nickname: nickname,
//                       departmentId: departmentId
//                   ),
//                   encoder: JSONParameterEncoder.default
//               )
//               .validate()
//               .responseDecodable(of: SignupResponse.self) { response in
//                   switch response.result {
//                   case .success(let responseData):
//                       print("회원가입 성공: \(responseData)")
//                       self.signupErrorMessage = "예상치 못한 오류가 발생했습니다."
//                       continuation.resume(returning: false)
//                   case .failure(_):
//                       if let data = response.data, let serverMessage = String(data: data, encoding: .utf8) {
//                           print("서버 오류 메시지: \(serverMessage)")
//                       }
//                       self.signupErrorMessage = nil
//                       continuation.resume(returning: true)
//                   }
//               }
    
    // 이메일 인증 요청
    func sendEmailToServer() async -> Bool {
        guard !email.isEmpty else { return false }
        
        let parameters: [String: Any] = ["email": email]
        
        return await withCheckedContinuation { continuation in
            NetworkRunner.shared.request("/auth/send-code", method: .get, parameters: parameters) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        print("이메일 전송 요청 성공")
                        continuation.resume(returning: true) // 성공 시 true 반환
                    case .failure(let error):
                        print("오류 발생: \(error.localizedDescription)")
                        continuation.resume(returning: false) // 실패 시 false 반환
                    }
                }
            }
        }
    }
// 추상화 전 코드 오류 나는지 확인 후에 삭제하자~
//    func sendEmailToServer() {
//        guard !email.isEmpty else { return }
//        
//        let url = serverUrl.getUrl(for: "/auth/send-code")
//        let parameters: [String: Any] = ["email": email]
//        
//        AF.request(
//            url,
//            method: .get,
//            parameters: parameters,
//            encoding: URLEncoding.default
//        )
//        .validate()
//        .response { response in
//            DispatchQueue.main.async {
//                if let error = response.error {
//                    print("오류 발생: \(error)")
//                } else {
//                    print("이메일 전송 요청 성공")
//                }
//            }
//        }
//    }
    
    // 인증 코드 확인 비동기 함수
    func verifyCode() async -> Bool {
        guard !email.isEmpty, !code.isEmpty else { return false }
        
        let parameters: [String: String] = ["email": email, "code": code]
        
        return await withCheckedContinuation { continuation in
            NetworkRunner.shared.request("/auth/verify-code", method: .post, parameters: parameters) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        print("인증번호 확인 성공")
                        continuation.resume(returning: true)
                    case .failure(let error):
                        print("인증번호 확인 실패: \(error.localizedDescription)")
                        continuation.resume(returning: false)
                    }
                }
            }
        }
    }
// 마찬가지
//    func verifyCode() async -> Bool {
//        guard !email.isEmpty, !code.isEmpty else { return false }
//        
//        let parameters: [String: String] = ["email": email, "code": code]
//        let url = serverUrl.getUrl(for: "/auth/verify-code")
//        
//        return await withCheckedContinuation { continuation in
//            AF.request(
//                url,
//                method: .post,
//                parameters: parameters,
//                encoding: URLEncoding.default
//            )
//            .validate(statusCode: 200..<300)
//            .response { response in
//                switch response.result {
//                case .success:
//                    print("인증번호 확인 성공")
//                    continuation.resume(returning: true)
//                case .failure(let error):
//                    if let data = response.data, let errorResponse = String(data: data, encoding: .utf8) {
//                        print("서버 응답 오류 메시지: \(errorResponse)")
//                    }
//                    print("인증번호 확인 실패: \(error.localizedDescription)")
//                    continuation.resume(returning: false)
//                }
//            }
//        }
//    }
}
