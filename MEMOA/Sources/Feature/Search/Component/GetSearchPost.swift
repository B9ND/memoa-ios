//
//  GetSearchPost.swift
//  MEMOA
//
//  Created by dgsw30 on 10/25/24.
//

import SwiftUI

struct GetSearchPost: View {
    @ObservedObject var searchVM: SearchViewModel
    @ObservedObject var getPostVM = GetPostViewModel()
    @State private var toDetail = false
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                if searchVM.noLoading {
                        Image(icon: .loading)
                            .resizable()
                            .frame(width: 136, height: 136)
                            .padding(.vertical, 4)
                        Text("검색결과가 없어요!")
                } else {
                    ForEach(searchVM.posts, id: \.id) { post in
                        SearchComponentView(post: post) {
                            getPostVM.id = post.id
                            getPostVM.getDetailPost()
                            toDetail = true
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .refreshable {
                searchVM.getPost()
            }
        }
        .navigationDestination(isPresented: $toDetail) {
            if let detailPost = getPostVM.detailPosts.first {
                DetailView(getPost: detailPost)
            }
        }
    }
}
