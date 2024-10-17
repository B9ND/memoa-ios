import SwiftUI

struct SchoolModel {
    var school : String = ""
    var selectSchool = [schooLlist]()
}

struct schooLlist: Identifiable, Hashable {
    var id: UUID
    var schoolname: String
    
    init(schoolname: String = "") {
        self.id = UUID()
        self.schoolname = schoolname
    }
}
