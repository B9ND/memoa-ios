import Foundation

class ChangeDepartmentViewModel: ObservableObject {
    @Published var findSchool: [schoollist] = [
        schoollist(schoolname: "대구소프퉤퉤"),
        schoollist(schoolname: "대구소프퉤퉤"),
        schoollist(schoolname: "대구소프퉤퉤"),
        schoollist(schoolname: "대구소프퉤퉤")
    ]
}
