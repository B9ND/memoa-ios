import SwiftUI

struct ProfileView: View {
    // MARK: 상대방프로필 뷰
    @StateObject private var follow = ProfileViewModel()
    @StateObject private var followerVM = FollowerViewModel()
    @StateObject private var followingVM = FollowingViewModel()
    @StateObject private var postVM = MyProfileViewModel()
    @State private var toDetail = false
    let information: GetDetailPost
    
    var body: some View {
        NavigationView {
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
                            .cornerRadius(30, corners: .topLeft)
                            .cornerRadius(30, corners: .topRight)
                            .overlay {
                                VStack {
                                    ZStack {
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: 100, height: 100)
                                            .padding(.top, -44)
                                            .overlay {
                                                Image(icon: .bigProfile)
                                                    .padding(.top, -44)
                                            }
                                    }
                                    HStack {
                                        Text(information.author)
                                            .font(.medium(16))
                                    }
                                    .padding(.bottom, 4)
                                    .padding(.leading, 2)
                                    
                                    HStack {
                                        VStack {
                                            Myfollower(board: followModel(nickname: information.author, number: String(followerVM.followers.count)), text: "팔로워")
                                                .padding(.horizontal, 16)
                                                .environmentObject(followerVM)
                                        }
                                        VStack {
                                            Myfollowing(board: followModel(nickname: information.author, number: String(followingVM.followings.count)), text: "팔로잉")
                                                .padding(.horizontal, 16)
                                                .environmentObject(followingVM)
                                        }
                                    }
                                    .padding(.bottom , 5)
                                    VStack {
                                        Button {
                                            if follow.isFollow {
                                                follow.deleteFollow(nickname: information.author)
                                            } else {
                                                follow.follow(nickname: information.author)
                                            }
                                        } label: {
                                            Text(follow.isFollow ? "언팔로우" : "팔로우")
                                                .font(.regular(10))
                                                .frame(width: 87, height: 21)
                                                .background(follow.isFollow ?  Color.white : Color.maincolor)
                                                .cornerRadius(8)
                                                .foregroundStyle(follow.isFollow ? .black : .white)
                                                .overlay {
                                                    if follow.isFollow {
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(Color.graycolor, lineWidth: 1)
                                                    }
                                                }
                                        }
                                    }
                                    .padding(.bottom ,10)
                                    Spacer()
                                    
                                    Divider()
                                    ScrollView {
                                        LazyVStack {
                                            ForEach(postVM.myPosts, id: \.id) { post in
                                                MypostComponent(post: post) {
                                                    postVM.id = post.id
                                                    postVM.getDetailPost()
                                                    toDetail = true
                                                }
                                            }
                                        }
                                        Spacer()
                                    }
                                }
                            }
                    }
                    .ignoresSafeArea()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            postVM.fetchMyPost(author: information.author)
            follow.fetchMy()
            followerVM.getFollower(user: information.author)
            followingVM.getFollowing(user: information.author)
        }
        .navigationDestination(isPresented: $toDetail) {
            if let detailPost = postVM.detailPosts.first {
                DetailView(getPost: detailPost)
            }
        }
        BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .black)
    }
}
