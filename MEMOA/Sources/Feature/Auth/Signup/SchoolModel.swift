import Foundation

struct SchoolModel {
    var school: String = ""
    var selectSchool = [SchoolList]()
}

struct SchoolList: Identifiable, Hashable {
    var id: UUID
    var schoolname: String
    
    init(schoolname: String = "") {
        self.id = UUID() 
        self.schoolname = schoolname
    }
}


struct SchoolListResponse: Decodable {
    let id: Int
    let name: String
    let departments: [DepartmentResponse]
}

struct DepartmentResponse: Decodable {
    let id: Int
    let name: String
    let grade: Int
    let subjects: [String]
}

struct SchoolPostRequest: Encodable {
    let name: String
    let departments: [DepartmentPostRequest]
}

struct DepartmentPostRequest: Encodable {
    let name: String
    let grade: Int
    let subjects: [String]
}
