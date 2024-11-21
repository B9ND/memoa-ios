import SwiftUI
import UIKit

// MARK: 홈뷰
struct HomeView: View {
    @EnvironmentObject private var myProfileVM: MyProfileViewModel
    @StateObject private var getPostVM = GetPostViewModel()
    @State private var toDetail = false
    var body: some View {
        NavigationStack {
            VStack {
                SelectitemView(postVM: getPostVM)
                Divider()
                ScrollView {
                    LazyVStack {
                        Spacer()
                        if getPostVM.posts.isEmpty {
                            VStack {
                                Spacer()
                                Image(icon: .loading)
                                    .resizable()
                                    .frame(width: 136, height: 136)
                                    .padding(.vertical, 4)
                                Text("검색결과가 없어요!")
                                Spacer()
                            }
                        } else {
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
                    }
                    Spacer()
                }
                .onAppear {
                    if let information = myProfileVM.profile {
                        getPostVM.tags.append(information.department.school)
                    }
                    getPostVM.loadPost()
                }
                .refreshable {
                    if !getPostVM.canLoadMore {
                        getPostVM.page = 0
                        getPostVM.canLoadMore = true
                        getPostVM.posts.removeAll()
                        getPostVM.loadPost()
                    }
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
