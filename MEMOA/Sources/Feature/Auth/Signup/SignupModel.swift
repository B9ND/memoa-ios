import SwiftUI

struct SignupModel: Encodable {
    var email: String = ""
    var code : String = ""
    var password : String = ""
    var nickname : String = ""
    
    var isSecure: Bool = true
    
    // 타이머 상태 관리 변수
    var isTimerRunning = false // 타이머 실행 여부
    var remainingTime = 0 // 남은 시간 (초 단위)
}
