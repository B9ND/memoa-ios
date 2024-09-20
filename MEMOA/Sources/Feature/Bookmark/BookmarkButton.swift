import SwiftUI

struct BookmarkButton: View {
    @StateObject private var addbookmarkVM = BookmarkViewModel()
    @State private var clickbookmark = false
    @State private var bookmarkcount = 0
    @State private var showingalert = false
    
    var body: some View {
        Button {
            let addView = UploadComponentView()
            if clickbookmark {
                addbookmarkVM.removeBookmark(at: IndexSet())
                bookmarkcount -= 1
            } else {
                showingalert.toggle()
                addbookmarkVM.addBookmark(view: addView)
                bookmarkcount += 1
            }
            clickbookmark.toggle()
            saveBookmark() // 클릭 시 북마크 상태 저장
        } label: {
            Image(clickbookmark ? .clickbm : .bm )
                .resizable()
                .frame(width: 13, height: 16)
            Text("\(bookmarkcount)")
                .font(.custom("Pretendard-Medium", size: 16))
                .foregroundStyle(.timecolor)
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
        UserDefaults.standard.set(bookmarkcount, forKey: "bookmarkcount") // 북마크 개수 저장
    }
    
    func loadBookmark() {
        // 저장된 북마크 상태가 있다면 불러옴
        if let savedBookmark = UserDefaults.standard.value(forKey: "clickbookmark") as? Bool {
            clickbookmark = savedBookmark
        }
        // 저장된 북마크 개수 불러옴
        if let savedCount = UserDefaults.standard.value(forKey: "bookmarkcount") as? Int {
            bookmarkcount = savedCount
        }
    }
}

#Preview {
    BookmarkButton()
}
