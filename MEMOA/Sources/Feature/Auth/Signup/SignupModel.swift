import SwiftUI

struct SignupModel: Encodable {
    var email: String = ""
    var nickname: String = ""  // code 위치에서 이동
    var password: String = ""
    var departmentId: Int? = nil  // nickname 위치에서 이동
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
