import SwiftUI

struct BookmarkModel: Identifiable, Equatable {
    static func == (lhs: BookmarkModel, rhs: BookmarkModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    var bookmarkview: AnyView
}
