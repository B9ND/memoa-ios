import Foundation

struct ProfileModel: Codable {
    var email: String
    var nickname: String
    var description: String?
    var profileImage: String
    var department: ProfileDepartment
    var followed: Bool
}

struct ProfileDepartment: Codable {
    var name: String
    var grade: Int
    var school: String
    var subjects: [String]
}
