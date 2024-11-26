import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isSecure: Bool = true
    @Published var loginerrorMessage: String?
    
    var isLoginDisabled: Bool {
        email.isEmpty || password.isEmpty
    }
    func login(completion: @escaping (Bool) -> Void) {
        
        NetworkRunner.shared.request("/auth/login", method: .post, parameters: LoginModel(email: email, password: password), response: TokenResponse.self) { result in
            switch result {
            case .success(let tokenResponse):
                UserDefaults.standard.setValue(tokenResponse.accessToken, forKey: "access")
                UserDefaults.standard.setValue(tokenResponse.refreshToken, forKey: "refresh")
                completion(true)
            case .failure(let error):
                self.loginerrorMessage = error.localizedDescription
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}
