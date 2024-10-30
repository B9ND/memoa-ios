import Foundation
import Alamofire

class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var code: String = ""
    @Published var password: String = ""
    @Published var nickname: String = ""
    let serverUrl = ServerUrl.shared
    
    @Published var isSecure: Bool = true
    @Published var signupErrorMessage: String? = nil
    
    @Published var isTimerRunning: Bool = false
    @Published var remainingTime: Int = 0
    
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
        email.isEmpty || password.isEmpty || nickname.isEmpty
    }
    
    func signup() async -> Bool {
        let url = serverUrl.getUrl(for: "/auth/register")
        
        return await withCheckedContinuation { continuation in
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
                case .success(_):
                    print("회원가입 성공")
                    self.signupErrorMessage = nil
                    continuation.resume(returning: true)
                case .failure(let error):
                    print("회원가입 실패: \(error)")
                    self.signupErrorMessage = "예상치 못한 오류가 발생했습니다."
                    continuation.resume(returning: false)
                }
            }
        }
    }
    
    func sendEmailToServer() {
        guard !email.isEmpty else { return }
        
        let url = serverUrl.getUrl(for: "/auth/send-code")
        let parameters: [String: Any] = ["email": email]
        
        AF.request(
            url,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.default
        )
        .validate()
        .response { response in
            if let error = response.error {
                print("오류 발생: \(error)")
            } else {
                print("이메일 전송 요청 성공")
            }
        }
    }
    
    
    func verifyCode() async -> Bool {
        guard !email.isEmpty, !code.isEmpty else { return false }
        
        let url = serverUrl.getUrl(for: "/auth/verify-code")
        
        return await withCheckedContinuation { continuation in
            var continuationCalled = false // 중복 호출 방지 플래그
            
            AF.request(
                url,
                method: .post,
                parameters: SignupModel(
                    email: email,
                    code: code
                ),
                encoder: JSONParameterEncoder.default
            )
            .validate(statusCode: 200..<300)
            .response { response in
                // 중복 호출 방지 조건 추가
                guard !continuationCalled else { return }
                continuationCalled = true
                
                switch response.result {
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
