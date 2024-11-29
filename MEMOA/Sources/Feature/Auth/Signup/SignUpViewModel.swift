import Foundation
import Alamofire

// 공통 Response 모델
struct CommonResponse: Decodable {
    let status: Int
    let message: String
}

class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var code: String = ""
    @Published var password: String = ""
    @Published var nickname: String = ""
    @Published var signupErrorMessage: String = ""
    @Published var remainingTime: Int = 0
    @Published var departmentId: Int?
    @Published var isSecure: Bool = true
    @Published var isTimerRunning: Bool = false
    
    private var timer: Timer?
    
    enum SignUpError: LocalizedError {
        case invalidEmail
        case invalidPassword
        case serverError(String)
        case invalidCode
        
        var errorDescription: String? {
            switch self {
            case .invalidEmail:
                return "유효하지 않은 이메일 형식입니다"
            case .invalidPassword:
                return "비밀번호는 5자 이상이어야 합니다"
            case .serverError(let message):
                return message
            case .invalidCode:
                return "유효하지 않은 인증번호입니다"
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 5
    }
    
    func startCountdown() {
        stopTimer()
        remainingTime = 300
        isTimerRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            DispatchQueue.main.async {
                if self.remainingTime > 0 {
                    self.remainingTime -= 1
                } else {
                    self.stopTimer()
                }
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
    }
    
    deinit {
        stopTimer()
    }
    
    var isSignupDisabled: Bool {
        !isValidEmail(email) || nickname.isEmpty || !isValidPassword(password) || departmentId == nil
    }
    
    // MARK: - Network Methods
    func signup() async -> Result<SignupResponse, Error> {
        return await withCheckedContinuation { continuation in
            NetworkRunner.shared.request(
                "/auth/register",
                method: .post,
                parameters: SignupModel(
                    email: email,
                    nickname: nickname,
                    password: password,
                    departmentId: departmentId ?? 0
                ),
                response: SignupResponse.self
            ) { result in
                switch result {
                case .success(_):
                    continuation.resume(returning: .failure(SignUpError.serverError("회원가입에 실패하였습니다")))
                case .failure:
                    let dummyResponse = SignupResponse(
                        email: "",
                        nickname: "",
                        description: "",
                        profileImage: "",
                        department: DepartmentInfo(name: "", grade: 0, school: "", subjects: [])
                    )
                    continuation.resume(returning: .success(dummyResponse))
                }
            }
        }
    }
    
    func sendEmailToServer() async -> Result<String, Error> {
        guard !email.isEmpty else {
            return .failure(SignUpError.invalidEmail)
        }
        
        guard isValidEmail(email) else {
            return .failure(SignUpError.invalidEmail)
        }
        
        return await withCheckedContinuation { continuation in
            NetworkRunner.shared.query(
                "/auth/send-code",
                method: .get,
                parameters: ["email": email]
            ) { result in
                switch result {
                case .success:
                    continuation.resume(returning: .success("인증 코드가 이메일로 전송되었습니다"))
                case .failure:
                    continuation.resume(returning: .failure(SignUpError.serverError("이메일 전송에 실패했습니다")))
                }
            }
        }
    }
    
    func verifyCode() async -> Result<Bool, Error> {
        guard !email.isEmpty, !code.isEmpty else {
            return .failure(SignUpError.invalidCode)
        }
        
        return await withCheckedContinuation { continuation in
            NetworkRunner.shared.query(
                "/auth/verify-code",
                method: .post,
                parameters: ["email": email, "code": code]
            ) { result in
                switch result {
                case .success:
                    continuation.resume(returning: .success(true))
                case .failure:
                    continuation.resume(returning: .failure(SignUpError.invalidCode))
                }
            }
        }
    }
}
