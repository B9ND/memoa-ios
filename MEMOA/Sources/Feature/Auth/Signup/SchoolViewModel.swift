import SwiftUI
import Alamofire

class SchoolViewModel: ObservableObject {
    @Published var serverUrl = ServerUrl.shared
    @Published var request = SchoolModel()
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var getSchool: [School] = []
    @Published var schoolName = ""
    @Published var selectedSchoolDepartments: [Department] = []

    func resetSchoolList() {
        getSchool = []
        errorMessage = nil
    }

    func fetchSchoolList(searchQuery: String) {
        let url = serverUrl.getUrl(for: "/school/search?search=\(searchQuery)")
        
        isLoading = true
        errorMessage = nil
        
        NetworkRunner.shared.request("/school/search?search=\(searchQuery)", method: .get, response: [School].self) { response in
        DispatchQueue.main.async {
            self.isLoading = false
            switch response {
            case .success(let schoolList):
                self.getSchool = schoolList
            case .failure(let error):
                self.errorMessage = "데이터를 불러오지 못했습니다: \(error.localizedDescription)"
            }
// 추상화 전 코드 테스트 후 지우기
//        AF.request(url, method: .get)
//            .validate()
//            .responseDecodable(of: [School].self) { response in
//                DispatchQueue.main.async {
//                    self.isLoading = false
//                    switch response.result {
//                    case .success(let schoolList):
//                        self.getSchool = schoolList
//                    case .failure(let error):
//                        self.errorMessage = "데이터를 불러오지 못했습니다: \(error.localizedDescription)"
//                    }
                }
            }
    }
    
    func updateDepartments(for grade: Int) {
        selectedSchoolDepartments = getSchool
            .first { $0.name == schoolName }?
            .departments
            .filter { $0.grade == grade } ?? []
    }
}
