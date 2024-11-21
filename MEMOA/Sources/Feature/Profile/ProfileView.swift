import SwiftUI

struct ProfileView: View {
    // MARK: 상대방프로필 뷰
    @StateObject private var profileVM = ProfileViewModel()
    @StateObject private var followerVM = FollowerViewModel() //팔로우
    @StateObject private var followingVM = FollowingViewModel() //팔로워
    @State private var toDetail = false
    @Binding var username: String
    
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
                                        if let profile = profileVM.profile,
                                           let url = URL(string: profile.profileImage) {
                                            AsyncImage(url: url) { image in
                                                image
                                                    .resizable()
                                                    .frame(width: 90, height: 90)
                                                    .scaledToFit()
                                                    .clipShape(Circle())
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .padding(.top, -44)
                                        }
                                    }
                                
                                    if let profile = profileVM.profile {
                                        VStack {
                                            Text(profile.nickname)
                                                .font(.medium(16))
                                                .padding(.bottom, 2)
                                            
                                            //MARK: description
                                            Text(profile.description ?? "설명이 없습니다.")
                                                .foregroundStyle(.black)
                                                .font(.regular(12))
                                                .padding(.bottom, 14)
                                        }
                                        
                                        HStack {
                                            VStack {
                                                Myfollower(board: followModel(nickname: username, number: String(followerVM.followers.count)), text: "팔로워")
                                                    .padding(.horizontal, 16)
                                                    .environmentObject(followerVM)
                                            }
                                            VStack {
                                                Myfollowing(board: followModel(nickname: username, number: String(followingVM.followings.count)), text: "팔로잉")
                                                    .padding(.horizontal, 16)
                                                    .environmentObject(followingVM)
                                            }
                                        }
                                        .padding(.bottom , 5)
                                        VStack {
                                            if profileVM.email == profileVM.myEmail {
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
                                                    profileVM.followed.toggle()
                                                    profileVM.follow(nickname: username)
                                                } label: {
                                                    Text(profileVM.followed ? "언팔로우" : "팔로우")
                                                        .font(.regular(10))
                                                        .frame(width: 87, height: 21)
                                                        .background(profileVM.followed ? Color.white : Color.maincolor)
                                                        .cornerRadius(8)
                                                        .foregroundStyle(profileVM.followed ? .black : .white)
                                                        .overlay {
                                                            if profileVM.followed {
                                                                RoundedRectangle(cornerRadius: 10)
                                                                    .stroke(Color.graycolor, lineWidth: 1)
                                                            }
                                                        }
                                                }
                                            }
                                        }
                                        .padding(.bottom ,10)
                                        Spacer()
                                    }
                                    
                                    Divider()
                                    ScrollView {
                                        LazyVStack {
                                            ForEach(profileVM.myPosts, id: \.id) { post in
                                                OtherpostComponent(post: post) {
                                                    profileVM.id = post.id
                                                    profileVM.getDetailPost()
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
            profileVM.getUser(nickname: username)
            profileVM.OtherPost(author: username)
            profileVM.fetchMy()
            followerVM.getFollower(nickname: username)
            followingVM.getFollowing(nickname: username)
        }
        .navigationDestination(isPresented: $toDetail) {
            if let detailPost = profileVM.detailPosts.first {
                DetailView(getPost: detailPost)
            }
        }
        BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .black)
    }
}
