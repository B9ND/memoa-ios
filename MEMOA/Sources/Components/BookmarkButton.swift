import SwiftUI

//MARK: 북마크 추가버튼
struct BookmarkButton: View {
    @StateObject private var bookmarkVM = BookmarkViewModel()
    @Binding var isBookmark: Bool
    @Binding var id : Int
    
    var body: some View {
        Button {
            bookmarkVM.bookmark(id: id)
        } label: {
            Image(icon: bookmarkVM.isBoomark ? .clickbookmark : .bookMark)
                .resizable()
                .frame(width: 13, height: 16)
        }
        .onAppear {
            bookmarkVM.isBoomark = isBookmark
        }
    }
}
