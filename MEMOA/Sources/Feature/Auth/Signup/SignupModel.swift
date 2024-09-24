import SwiftUI

struct SignupModel: Encodable {
    var email: String = ""
    var code : String = ""
    var password : String = ""
    var nickname : String = ""
    
    var signupparams: [String : Any]? {
        return [
            "email": email,
            "password": password,
            "nickname": nickname
        ]
    }
    
    var isSecure: Bool = true
}
