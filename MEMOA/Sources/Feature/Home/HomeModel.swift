import Foundation


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

struct HomeModel {
    var school: [schoolitem]
    var grade: [gradeitem]
}



// upload 이미지
struct Imagecard: Identifiable, Hashable {
    var id: UUID = .init()
    var image: String
}
