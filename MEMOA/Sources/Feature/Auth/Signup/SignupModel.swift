import SwiftUI

struct SignupModel: Encodable {
    var email: String = ""
    var code : String = ""
    var password : String = ""
    var nickname : String = ""
    
    var isSecure: Bool = true
    
    var isTimerRunning = false
    var remainingTime = 0
}
