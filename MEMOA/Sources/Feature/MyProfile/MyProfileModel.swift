import Foundation

struct MyProfileModel: Codable {
    var email: String
    var nickname: String
    var description: String?
    var profileImage: String
    var department: MyProfileDepartment
    var followed: Bool
}

struct MyProfileDepartment: Codable {
    var name: String
    var grade: Int
    var school: String
    var subjects: [String]
}
