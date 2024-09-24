import SwiftUI
import Combine
import Foundation

class BookmarkViewModel: ObservableObject {
    @Published var bookmarks: [BookmarkModel] = []
    
    func addBookmark<T: View>(view: T) {
        let newBookmark = BookmarkModel(bookmarkview: AnyView(view))
        bookmarks.append(newBookmark)
    }
    
    func removeBookmark(at indexSet: IndexSet) {
        bookmarks.remove(atOffsets: indexSet)
    }
}
