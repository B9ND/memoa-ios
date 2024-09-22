import SwiftUI

struct LoginModel: Encodable {
    var email: String = ""
    var password: String = ""
    var isSecure: Bool = true
}
