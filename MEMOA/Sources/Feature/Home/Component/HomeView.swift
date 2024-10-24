import SwiftUI

// MARK: 홈뷰
struct HomeView: View {
    @StateObject var getPostVM = GetPostViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                SelectitemView()
                Divider()
                ScrollView {
                    ForEach(getPostVM.posts, id: \.id) { post in
                        LazyVStack {
                            UploadComponentView(post: post) {
                                print("성공")
                            }
                        }
                        if getPostVM.isLoading {
                            ProgressView()
                        } else {
                            GeometryReader { geometry in
                                Color.clear
                                    .onAppear {
                                        if geometry.frame(in: .global).maxY < UIScreen.main.bounds.height {
                                            if getPostVM.canLoadMore {
                                                getPostVM.post()
                                            }
                                        }
                                    }
                            }
                            .frame(height: 50)
                        }
                    }
                    Spacer()
                }
                .onAppear {
                    getPostVM.post()
                }
                .refreshable {
                    getPostVM.page = 0
                    getPostVM.posts.removeAll()
                    getPostVM.canLoadMore = true
                    getPostVM.post()
                }
            }
        }
    }
}
