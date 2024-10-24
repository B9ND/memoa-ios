import Foundation

struct ChangeDepartmentModel {
    var selectschangechool: [ShowsChoolList]
}

struct ShowsChoolList: Identifiable {
    var id: UUID
    var schoolName : String
    
    init(id: UUID, schoolName: String) {
        self.id = id
        self.schoolName = schoolName
    }
}
