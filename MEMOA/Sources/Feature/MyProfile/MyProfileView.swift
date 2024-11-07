import SwiftUI

struct MyProfileView: View {
    //MARK: 내 프로필 뷰
    @StateObject private var follow = ProfileViewModel()
    @StateObject private var followerVM = FollowerViewModel()
    @StateObject private var followingVM = FollowingViewModel()
    @StateObject private var myProfileVM = MyProfileViewModel()
    @StateObject private var modifyVM = ModifyViewModel()
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
                                    if let url = URL(string: myProfileVM.profileImage) {
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
                                    Text(myProfileVM.name)
                                        .font(.medium(16))
                                        .padding(.bottom, 2)
                                    
                                    //MARK: description
                                    Text(myProfileVM.description.isEmpty ? "설명이 없습니다" : myProfileVM.description)
                                        .foregroundStyle(.black)
                                        .font(.regular(12))
                                        .padding(.bottom, 14)
                                }
                                
                                
                                HStack {
                                    VStack {
                                        Myfollower(board: followModel(nickname: myProfileVM.name, number: String(followerVM.followers.count)), text: "팔로워")
                                            .padding(.horizontal, 16)
                                    }
                                    VStack {
                                        Myfollowing(board: followModel(nickname: myProfileVM.name, number: String(followingVM.followings.count)), text: "팔로잉")
                                            .padding(.horizontal, 16)
                                    }
                                }
                                .padding(.bottom , 5)
                                
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
                            }
                        }
                }
                .navigationDestination(isPresented: $modify) {
                    ModifyView(profileMV: myProfileVM, modifyVM: modifyVM)
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
        .onAppear {
            myProfileVM.fetchMy(followerVM: followerVM, followingVM: followingVM)
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


