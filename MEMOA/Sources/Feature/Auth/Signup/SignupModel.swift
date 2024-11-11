import SwiftUI

struct SignupModel: Encodable {
    var email: String = ""
    var code : String = ""
    var password : String = ""
    var nickname : String = ""
    var departmentId: Int? = nil
    
    var isSecure: Bool = true
    
    var isTimerRunning = false
    var remainingTime = 0
}

struct SignupResponse: Decodable {
    var email: String
    var nickname: String
    var description: String
    var profileImage: String
    var department: DepartmentInfo
}

struct DepartmentInfo: Decodable {
    var name: String
    var grade: Int
    var school: String
    var subjects: [String]
}
