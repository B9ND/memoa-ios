import SwiftUI

struct ProfileView: View {
    // MARK: 프로필 뷰
    var board: BoardModel
    
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
                                        Text(board.nickname)
                                            .font(.medium(16))
                                    }
                                    .padding(.bottom, 4)
                                    .padding(.leading, 2)
                                    Text(board.email)
                                        .foregroundStyle(.black)
                                        .font(.regular(12))
                                        .padding(.bottom, 14)
                                    
                                    HStack {
                                        VStack {
                                            Myfollower(board: followModel(nickname: board.nickname, number: "123"), text: "팔로워")
                                                .padding(.horizontal, 16)
                                        }
                                        VStack {
                                            Myfollowing(board: followModel(nickname: board.nickname, number: "144"), text: "팔로잉")
                                                .padding(.horizontal, 16)
                                        }
                                    }
                                    .padding(.bottom , 5)
                                    VStack {
                                        FollowButton {
                                            print("클릭")
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
        BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .black)
    }
}
