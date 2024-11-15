import Foundation

struct SelectSchoolModel {
    var grade: [gradeitem]
}

struct gradeitem: Encodable {
    var grade: Int
    
    init(grade: Int) {
        self.grade = grade
    }
}
