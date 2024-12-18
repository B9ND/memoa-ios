import SwiftUI
import Alamofire

class SchoolViewModel: ObservableObject {
    @Published var request = SchoolModel()
    @Published var selectedSchoolDepartments: [Department] = []
    @Published var getSchool: [School] = []
    @Published var errorMessage: String?
    @Published var schoolName = ""
    @Published var isLoading = false
    
    func resetSchoolList() {
        getSchool = []
        errorMessage = nil
    }
    
    func fetchSchoolList(searchQuery: String) {
        
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
