import SwiftUI

struct ProfileView: View {
    // MARK: 상대방프로필 뷰
    @StateObject private var followVM = ProfileViewModel()
    @StateObject private var followerVM = FollowerViewModel() //팔로우
    @StateObject private var followingVM = FollowingViewModel() //팔로워
    @StateObject private var postVM = MyProfileViewModel() //이거 내 게시물 불러올때만
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
                                        if let url = URL(string: information.authorProfileImage) {
                                            AsyncImage(url: url) { image in
                                                Circle()
                                                    .fill(Color.white)
                                                    .frame(width: 100, height: 100)
                                                    .padding(.top, -44)
                                                    .overlay {
                                                        image
                                                            .image?.resizable()
                                                            .cornerRadius(40, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
                                                            .frame(width: 80, height: 80)
                                                            .padding(.top, -44)
                                                    }
                                            }
                                        }
                                    }
                                    VStack {
                                        Text(information.author)
                                            .font(.medium(16))
                                            .padding(.bottom, 2)
                                        
                                        //MARK: description
                                        Text(followVM.description.isEmpty ? "설명이 없습니다." : followVM.description)
                                            .foregroundStyle(.black)
                                            .font(.regular(12))
                                            .padding(.bottom, 14)
                                    }
                                    
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
                                        if followVM.email == followVM.myEmail {
                                            Text("MY")
                                                .font(.regular(10))
                                                .frame(width: 87, height: 21)
                                                .background(Color.white)
                                                .cornerRadius(8)
                                                .foregroundStyle(.black)
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color.graycolor, lineWidth: 1)
                                                }
                                        } else {
                                            Button {
                                                followVM.followed.toggle()
                                                followVM.follow(nickname: information.author)
                                            } label: {
                                                Text(followVM.followed ? "언팔로우" : "팔로우")
                                                    .font(.regular(10))
                                                    .frame(width: 87, height: 21)
                                                    .background(followVM.followed ? Color.white : Color.maincolor)
                                                    .cornerRadius(8)
                                                    .foregroundStyle(followVM.followed ? .black : .white)
                                                    .overlay {
                                                        if followVM.followed {
                                                            RoundedRectangle(cornerRadius: 10)
                                                                .stroke(Color.graycolor, lineWidth: 1)
                                                        }
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
            followVM.getUser(nickname: information.author)
            postVM.fetchMyPost(author: information.author)
            followVM.fetchMy()
            followerVM.getFollower(nickname: information.author)
            followingVM.getFollowing(nickname: information.author)
        }
        .navigationDestination(isPresented: $toDetail) {
            if let detailPost = postVM.detailPosts.first {
                DetailView(getPost: detailPost)
            }
        }
        BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .black)
    }
}
