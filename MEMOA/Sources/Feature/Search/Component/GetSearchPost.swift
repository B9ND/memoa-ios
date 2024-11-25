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
                        ForEach(searchVM.posts, id: \.self) { serverResponse in
                            let post = GetPostModel(
                                id: serverResponse.id,
                                title: serverResponse.title,
                                author: serverResponse.author,
                                authorProfileImage: serverResponse.authorProfileImage,
                                tags: serverResponse.tags,
                                createdAt: serverResponse.createdAt,
                                images: serverResponse.images,
                                isBookmarked: serverResponse.isBookmarked
                            )
                            
                            UploadComponentView(post: post) {
                                getPostVM.id = post.id
                                getPostVM.getDetailPost()
                                toDetail = true
                            }
                            
                            if searchVM.isLoading {
                                ProgressView()
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
            if let detailPost = getPostVM.detailPosts.first {
                DetailView(getPost: detailPost)
            }
        }
    }
}
