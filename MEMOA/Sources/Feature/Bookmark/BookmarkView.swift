//
//  BookmarkView.swift
//  MEMOA
//
//  Created by dgsw30 on 8/24/24.
//

import SwiftUI

//MARK: 북마크뷰
struct Bookmark {
    let title: String
    let content: String
}

struct BookmarkView: View {
    @StateObject private var showingbookmarkVM = BookmarkViewModel()
    var body: some View {
        VStack {
            if showingbookmarkVM.bookmarks.isEmpty {
                Text("선택된 북마크가 없어요!")
                    .font(.bold(20))
            } else {
                ForEach(showingbookmarkVM.bookmarks) {
                    bookmark in
                    bookmark.bookmarkview   
                }
                //뷰를 보여주고 그에대한 데이터 이거 하지말고
            }
        }
    }
}

#Preview {
    BookmarkView()
}
