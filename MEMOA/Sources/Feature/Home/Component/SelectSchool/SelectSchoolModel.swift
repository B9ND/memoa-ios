import Foundation

struct SelectSchoolModel {
    var grade: [gradeitem]
}

struct gradeitem: Encodable {
    let id = UUID()
    var grade: Int
    
    init(grade: Int) {
        self.grade = grade
    }
}
