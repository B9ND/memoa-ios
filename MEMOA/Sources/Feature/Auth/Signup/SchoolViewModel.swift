import Foundation
import Alamofire

class SchoolModelView: ObservableObject {
    @Published var request: SchoolModel = .init(selectSchool: [
        schooLlist(schoolname: "대구소프트웨어마이스터고"),
        schooLlist(schoolname: "대덕소프트웨어마이스터고"),
        schooLlist(schoolname: "광주소프트웨어마이스터고"),
        schooLlist(schoolname: "부산소프트웨어마이스터고")
    ])
}
