import Foundation

struct MyProfileModel: Codable {
    var email: String
    var nickname: String
    var description: String?
    var profileImage: String
    var department: MyProfileDepartment
}

struct MyProfileDepartment: Codable {
    var name: String
    var grade: Int
    var school: String
    var subjects: [String]
}
