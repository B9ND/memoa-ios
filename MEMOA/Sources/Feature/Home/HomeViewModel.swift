import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var request: HomeModel = .init(school: [
        schoolitem(school: "대구소프트웨어마이스터고"),
        schoolitem(school: "대덕소프트웨어마이스터고"),
        schoolitem(school: "부산소프트웨어마이스터고"),
        schoolitem(school: "광주소프트웨어마이스터고")
    ], grade: [
        gradeitem(grade: 1),
        gradeitem(grade: 2),
        gradeitem(grade: 3)
    ])
    
    @Published var selectedSchool: String = "대구소프트웨어마이스터고"
    @Published var selectedGrade: Int = 1
}
