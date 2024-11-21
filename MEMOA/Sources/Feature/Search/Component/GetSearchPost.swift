import SwiftUI

struct GetSearchPost: View {
    @ObservedObject var searchVM: SearchViewModel
    @ObservedObject var getPostVM = GetPostViewModel()
    @State private var toDetail = false
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                if searchVM.noPost {
                    VStack {
                        Image(icon: .loading)
                            .resizable()
                            .frame(width: 136, height: 136)
                            .padding(.vertical, 4)
                        Text("검색결과가 없어요!")
                    }
                    .padding(.top, 100)
                } else {
                    LazyVStack {
                        ForEach(searchVM.posts, id: \.self) { post in
                            SearchComponentView(post: post) {
                                getPostVM.id = post.id
                                getPostVM.getDetailPost()
                                toDetail = true
                            }
                            
                            // 무한 스크롤 로딩 로직
                            if searchVM.isLoading {
                                ProgressView()
                            } else {
                                GeometryReader { geometry in
                                    Color.clear
                                        .onAppear {
                                            if geometry.frame(in: .global).maxY < UIScreen.main.bounds.height {
                                                // 기존 getPost() 대신 fetchPosts() 사용
                                                if searchVM.canLoadMore {
                                                    searchVM.fetchPosts()
                                                }
                                            }
                                        }
                                }
                                .frame(height: 50)
                            }
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .refreshable {
                // 기존 page reset 대신 refreshPosts() 사용
                searchVM.refreshPosts()
            }
        }
        .navigationDestination(isPresented: $toDetail) {
            if let detailPost = getPostVM.detailPosts.first {
                DetailView(getPost: detailPost)
            }
        }
    }
}
