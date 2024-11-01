import SwiftUI
import UIKit

// MARK: 홈뷰
struct HomeView: View {
    @StateObject private var getPostVM = GetPostViewModel()
    @State private var toDetail = false
    
    var body: some View {
        NavigationStack {
            VStack {
                SelectitemView()
                Divider()
                ScrollView {
                    LazyVStack {
                        ForEach(getPostVM.posts, id: \.id) { post in
                            UploadComponentView(post: post) {
                                getPostVM.id = post.id
                                getPostVM.getDetailPost()
                                toDetail = true
                            }
                            if getPostVM.isLoading {
                                ProgressView()
                            } else {
                                GeometryReader { geometry in
                                    Color.clear
                                        .onAppear {
                                            if geometry.frame(in: .global).maxY < UIScreen.main.bounds.height {
                                                if getPostVM.canLoadMore && !getPostVM.isLoading {
                                                    getPostVM.page += 1
                                                    getPostVM.loadPost()
                                                }
                                            }
                                        }
                                }
                                .frame(height: 0)
                            }
                        }
                    }
                    Spacer()
                }
                .onAppear {
                    getPostVM.loadPost()
                }
                .refreshable {
                    getPostVM.page = 0
                    getPostVM.canLoadMore = true
                    getPostVM.posts.removeAll()
                    getPostVM.loadPost()
                }
            }
        }
        .navigationDestination(isPresented: $toDetail) {
            if let detailPost = getPostVM.detailPosts.first {
                DetailView(getPost: detailPost)
            }
        }
    }
}
