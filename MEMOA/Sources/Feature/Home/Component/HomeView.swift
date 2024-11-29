import SwiftUI
import UIKit

// MARK: 홈뷰
struct HomeView: View {
    @EnvironmentObject private var myProfileVM: MyProfileViewModel
    @StateObject private var getPostVM = GetPostViewModel()
    @State private var toDetail = false
    @State private var isShimmering = true

    var body: some View {
        NavigationStack {
            VStack {
                SelectitemView(postVM: getPostVM)
                Divider()
                ScrollView {
                    LazyVStack {
                        Spacer()
                        if getPostVM.posts.isEmpty {
                            if isShimmering {
                                ForEach(0..<10) { _ in
                                    ShimmerView()
                                }
                            } else {
                                VStack {
                                    Image(icon: .loading)
                                        .resizable()
                                        .frame(width: 136, height: 136)
                                    Text("글이 없어요!")
                                        .font(.bold(20))
                                }
                            }
                        } else {
                            ForEach(getPostVM.posts, id: \.id) { post in
                                UploadComponentView(post: post) {
                                    getPostVM.id = post.id
                                    getPostVM.getDetailPost()
                                    toDetail = true
                                    isShimmering = true
                                }
                                if getPostVM.isLoading {
                                    ShimmerView()
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
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 97)
                }
                .onAppear {
                    if getPostVM.posts.isEmpty {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation {
                                isShimmering = false
                            }
                        }
                    }
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
