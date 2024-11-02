import SwiftUI

struct MyProfileView: View {
    //MARK: 프로필 뷰
    @StateObject private var follow = ProfileViewModel()
    @StateObject var followerVM = FollowerViewModel()
    @StateObject var followingVM = FollowingViewModel()
    @StateObject var MyprofileMV = MyProfileViewModel()
    @State private var modify = false
    @State private var changeName = false
    
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
                                    Text(MyprofileMV.name)
                                        .font(.medium(16))
                                    Button {
                                        changeName = true
                                    } label: {
                                        Image(icon: .pencil)
                                    }
                                }
                                .padding(.leading, 20)
                                
                                //MARK: description
                                Text(MyprofileMV.description)
                                    .foregroundStyle(.black)
                                    .font(.regular(12))
                                    .padding(.bottom, 14)
                                
                                
                                HStack {
                                    VStack {
                                        Myfollower(board: followModel(nickname: MyprofileMV.name, number: String(followerVM.followers.count)), text: "팔로워")
                                            .padding(.horizontal, 16)
                                    }
                                    VStack {
                                        Myfollowing(board: followModel(nickname: MyprofileMV.name, number: String(followingVM.followings.count)), text: "팔로잉")
                                            .padding(.horizontal, 16)
                                    }
                                }
                                .padding(.bottom , 5)
                                
                                Divider()
                                ScrollView {
                                    Spacer()
                                }
                            }
                        }
                }
                .navigationDestination(isPresented: $changeName) {
                    ChangeNameView()
                }
                .navigationDestination(isPresented: $modify) {
                    ModifyView(profileMV: MyprofileMV)
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
            MyprofileMV.fetchMy(followerVM: followerVM, followingVM: followingVM)
        }
    }
}


#Preview {
    MyProfileView()
}


