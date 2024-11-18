import SwiftUI

//MARK: 북마크 추가버튼
struct BookmarkButton: View {
    @StateObject private var bookmarkVM = BookmarkViewModel()
    @Binding var id : Int
    @State private var clickbookmark = false
    @State private var showingAlert = false
    
    var body: some View {
        Button {
            bookmarkVM.bookmark(id: id)
        } label: {
            Image(icon: bookmarkVM.isBoomark ? .clickbookmark : .bookMark)
                .resizable()
                .frame(width: 13, height: 16)
                .alert(isPresented: $bookmarkVM.isBoomark) {
                    Alert(title: Text("북마크가 추가되었습니다"))
                }
        }
    }
}
