import SwiftUI

struct GetSearchPost: View {
    @ObservedObject var searchVM: SearchViewModel
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
                        ForEach(searchVM.posts, id: \.id) { post in
                            SearchPostComponent(post: post, action: {
                                searchVM.id = post.id
                                searchVM.getDetailPost()
                                toDetail = true
                            })
                            
                            if searchVM.isLoading {
                                ShimmerView()
                            } else {
                                GeometryReader { geometry in
                                    Color.clear
                                        .onAppear {
                                            if geometry.frame(in: .global).maxY < UIScreen.main.bounds.height {
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
                searchVM.refreshPosts()
            }
        }
        .navigationDestination(isPresented: $toDetail) {
            if let detailPost = searchVM.detailPosts.first {
                DetailView(getPost: detailPost)
            }
        }
    }
}
