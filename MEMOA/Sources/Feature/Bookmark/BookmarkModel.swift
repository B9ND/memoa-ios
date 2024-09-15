import SwiftUI

struct BookmarkModel: Identifiable, Equatable {
    var id = UUID()
    var view: AnyView
    
    static func == (lhs: BookmarkModel, rhs: BookmarkModel) -> Bool {
        return lhs.id == rhs.id
    }
}

