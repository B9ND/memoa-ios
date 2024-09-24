//
//  BookmarkView.swift
//  MEMOA
//
//  Created by dgsw30 on 8/24/24.
//

import SwiftUI

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
            }
        }
    }
}

#Preview {
    BookmarkView()
}
