import Foundation
import Alamofire

class SchoolModelView: ObservableObject {
    @Published var request: SchoolModel = .init(selectschool: [
        schoollist(schoolname: "대구소프트웨어마이스터고"),
        schoollist(schoolname: "대덕소프트웨어마이스터고"),
        schoollist(schoolname: "광주소프트웨어마이스터고"),
        schoollist(schoolname: "부산소프트웨어마이스터고")
    ])
}
