import Foundation

struct SelectSchoolModel {
    var school: [schoolitem]
    var grade: [gradeitem]
}

struct schoolitem: Encodable {
    var school: String
    
    init(school: String) {
        self.school = school
    }
}

struct gradeitem: Encodable {
    var grade: Int
    
    init(grade: Int) {
        self.grade = grade
    }
}
