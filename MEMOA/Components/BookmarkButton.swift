import SwiftUI

//MARK: 북마크 추가버튼
struct BookmarkButton: View {
//    @StateObject private var addbookmarkVM = BookmarkViewModel()
    @State private var clickbookmark = false
    @State private var showingalert = false
    
    var body: some View {
        Button {
            if clickbookmark {
            } else {
                showingalert.toggle()
            }
            clickbookmark.toggle()
            saveBookmark()
        } label: {
            Image(icon: clickbookmark ? .clickbookmark : .bookMark)
                .resizable()
                .frame(width: 13, height: 16)
                .alert(isPresented: $showingalert) {
                    Alert(title: Text("북마크가 추가되었습니다"))
                }
        }
        .onAppear {
            loadBookmark()
        }
    }

    // 북마크 상태 저장 함수
    func saveBookmark() {
        UserDefaults.standard.set(clickbookmark, forKey: "clickbookmark") // 북마크 상태 저장
    }
    
    func loadBookmark() {
        // 저장된 북마크 상태가 있다면 불러옴
        if let savedBookmark = UserDefaults.standard.value(forKey: "clickbookmark") as? Bool {
            clickbookmark = savedBookmark
        }
    }
}

#Preview {
    BookmarkButton()
}
