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
    @StateObject private var bookmarkVM = BookmarkViewModel()
    @State private var toDetail: Bool = false
    var body: some View {
        VStack {
            if bookmarkVM.noExist {
                VStack {
                    Text("선택된 북마크가 없어요!")
                        .font(.bold(20))
                }
            }
        }
        ScrollView {
            VStack {
                if !bookmarkVM.noExist {
                    ForEach(bookmarkVM.posts, id: \.postId) { post in
                        BookmarkComponentView(post: post) {
                            bookmarkVM.id = post.postId
                            bookmarkVM.getDetailPost()
                            toDetail = true
                        }
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 97)
        }
        .navigationDestination(isPresented: $toDetail) {
            if let detailPost = bookmarkVM.detailPosts.first {
                DetailView(getPost: detailPost)
            }
        }
        .onAppear {
            bookmarkVM.getBookmark()
        }
        .onDisappear {
            bookmarkVM.posts.removeAll()
        }
    }
}

#Preview {
    BookmarkView()
}
