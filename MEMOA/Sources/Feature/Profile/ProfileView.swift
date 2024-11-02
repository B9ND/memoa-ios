import SwiftUI

struct ProfileView: View {
    // MARK: 프로필 뷰
    @StateObject private var follow = ProfileViewModel()
    @StateObject var followerVM = FollowerViewModel()
    @StateObject var followingVM = FollowingViewModel()
    @State private var isFollow = false
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
                                            isFollow.toggle()
                                            isFollow ? follow.follow(nickname: information.author) : follow.deleteFollow(nickname: information.author)
                                        } label: {
                                            Text(isFollow ? "언팔로우" : "팔로우")
                                                .font(.regular(10))
                                                .frame(width: 87, height: 21)
                                                .background(isFollow ?  Color.white : Color.maincolor)
                                                .cornerRadius(8)
                                                .foregroundStyle(isFollow ? .black : .white)
                                                .overlay {
                                                    if isFollow {
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(Color.graycolor, lineWidth: 1)
                                                    }
                                                }
                                        }
                                    }
                                    .padding(.bottom ,10)
                                    Spacer()
                                    
                                }
                            }
                    }
                    .ignoresSafeArea()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            followerVM.getFollower(user: information.author)
            followingVM.getFollowing(user: information.author)
        }
        BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .black)
    }
}
