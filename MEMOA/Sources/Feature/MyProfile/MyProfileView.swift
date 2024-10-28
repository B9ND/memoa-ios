import SwiftUI

struct MyProfileView: View {
    //MARK: 프로필 뷰
    @StateObject var MyprofilMV: MyProfileViewModel = .init()
    //MARK: 이거 mvvm 하면 하기
    @State private var follow = false
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
                                    Text(MyprofilMV.name)
                                        .font(.medium(16))
                                    Button {
                                        changeName = true
                                    } label: {
                                        Image(icon: .pencil)
                                    }
                                }
                                .padding(.leading, 20)
                                
                                //MARK: description
                                Text("안녕하세요 저는 박재민")
                                    .foregroundStyle(.black)
                                    .font(.regular(12))
                                    .padding(.bottom, 14)
                                
                                
                                HStack {
                                    VStack {
                                        Myfollower(board: followModel(nickname: MyprofilMV.name, number: "123"), text: "팔로워")
                                            .padding(.horizontal, 16)
                                    }
                                    VStack {
                                        Myfollowing(board: followModel(nickname: MyprofilMV.name, number: "123"), text: "팔로잉")
                                            .padding(.horizontal, 16)
                                    }
                                }
                                .padding(.bottom, 15)
                                
                                Divider()
                                ScrollView {
                                    Spacer()
//                                    UploadComponentView(board: BoardModel(nickname: "유을", time: "2024-09-29", image: [Imagelist(image: "example")], title: "과학수학필기 공유합니다", tag: "공부하기싫다", email: "eunchan2815@gmail.com")) {
//                                        print("정보주기")
//                                    }
                                }
                            }
                        }
                }
                .navigationDestination(isPresented: $changeName) {
                    ChangeNameView()
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
    }
}


#Preview {
    MyProfileView()
}


