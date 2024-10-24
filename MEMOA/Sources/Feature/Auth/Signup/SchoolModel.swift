import SwiftUI

struct SchoolModel {
    var school : String = ""
    var selectschool = [schoollist]()
}

struct schoollist: Identifiable, Hashable {
    var id: UUID
    var schoolname: String
    
    init(schoolname: String = "") {
        self.id = UUID()
        self.schoolname = schoolname
    }
}
