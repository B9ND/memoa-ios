import Foundation

// 학과 정보
struct Department: Identifiable, Codable, Hashable {
    var id: Int
    var name: String
    var grade: Int
    var subjects: [String]
}

// 학교 정보
struct School: Codable, Hashable {
    var name: String
    var departments: [Department]
}

struct SchoolModel: Codable {
    var school: String = ""
    var selectSchool: [School] = []
}

