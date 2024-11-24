import SwiftUI

struct MyProfileView: View {
    //MARK: 내 프로필 뷰
    @EnvironmentObject var myProfileVM: MyProfileViewModel
    @StateObject private var follow = ProfileViewModel()
    @StateObject private var followerVM = FollowerViewModel()
    @StateObject private var followingVM = FollowingViewModel()
    @State private var toDetail = false
    @State private var modify = false
    
    var body: some View {
        ZStack {
            Color.maincolor
                .ignoresSafeArea()
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(Color.white)
                        .frame(maxWidth:.infinity)
                        .frame(height: geometry.size.height * 0.95)
                        .cornerRadius(30, corners: [.topLeft, .topRight])
                        .overlay {
                            VStack {
                                //MARK: 프로필 이미지
                                ZStack {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 100, height: 100)
                                        .padding(.top, -44)
                                        .overlay {
                                            Image(icon: .bigProfile)
                                                .padding(.top, -44)
                                        }
                                    ZStack {
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: 100, height: 100)
                                            .padding(.top, -44)
                                        if let profile = myProfileVM.profile,
                                           let url = URL(string: profile.profileImage) {
                                            AsyncImage(url: url) { image in
                                                image
                                                    .resizable()
                                                    .frame(width: 90, height: 90)
                                                    .scaledToFit()
                                                    .clipShape(Circle())
                                            } placeholder: {
                                                EmptyView()
                                            }
                                            .padding(.top, -44)
                                        }
                                    }
                                    
                                }
                                if let profile = myProfileVM.profile {
                                    VStack {
                                        Text(profile.nickname)
                                            .font(.medium(16))
                                            .padding(.bottom, 2)
                                        
                                        //MARK: description
                                        // TODO: Fix
                                        Text(profile.description ?? "설명이 없습니다.")
                                            .foregroundStyle(.black)
                                            .font(.regular(12))
                                            .padding(.bottom, 14)
                                    }
                                    
                                    
                                    HStack {
                                        VStack {
                                            Myfollower(board: followModel(nickname: profile.nickname, number: String(followerVM.followers.count)), text: "팔로워")
                                                .padding(.horizontal, 16)
                                        }
                                        VStack {
                                            Myfollowing(board: followModel(nickname: profile.nickname, number: String(followingVM.followings.count)), text: "팔로잉")
                                                .padding(.horizontal, 16)
                                        }
                                    }
                                    .padding(.bottom , 5)
                                }
                                
                                Divider()
                                ScrollView {
                                    LazyVStack {
                                        ForEach(myProfileVM.myPosts, id: \.id) { post in
                                            MypostComponent(post: post) {
                                                myProfileVM.id = post.id
                                                myProfileVM.getDetailPost()
                                                toDetail = true
                                            }
                                        }
                                    }
                                    Spacer()
                                }
                                .safeAreaInset(edge: .bottom) {
                                    Color.clear.frame(height: 97)
                                }
                            }
                        }
                }
                .navigationDestination(isPresented: $modify) {
                    ModifyView()
                }
                .ignoresSafeArea()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    modify = true
                } label: {
                    Image(icon: .setting)
                }
            }
        }
        .refreshable {
            if let profile = myProfileVM.profile {
                myProfileVM.myPosts.removeAll()
                myProfileVM.fetchMyPost(author: profile.nickname)
            }
        }
        .onAppear {
            if let profile = myProfileVM.profile {
                myProfileVM.fetchMy()
                myProfileVM.fetchMyPost(author: profile.nickname)
            }
        }
        .onReceive(myProfileVM.$profile) { profile in
            if let profile {
                followerVM.getFollower(nickname: profile.nickname)
                followingVM.getFollowing(nickname: profile.nickname)
            }
        }
        .navigationDestination(isPresented: $toDetail) {
            if let detailPost = myProfileVM.detailPosts.first {
                DetailView(getPost: detailPost)
            }
        }
    }
}


#Preview {
    MyProfileView()
}


