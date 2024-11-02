import SwiftUI

//MARK: 프로필 수정
struct ModifyView: View {
    @ObservedObject var profileMV: MyProfileViewModel
    
    @State private var showAlert = false
    @Environment(\.openURL) private var openURL
    @State private var changeName = false
    @State private var changeSchool = false
    
    var body: some View {
        ZStack {
            Color.graycolor
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
                                    Text(profileMV.name)
                                        .font(.medium(16))
                                    Button {
                                        changeName = true
                                    } label: {
                                        Image(icon: .pencil)
                                    }
                                }
                                .padding(.bottom, 4)
                                
                                .padding(.leading, 20)
                                Text(profileMV.email)
                                    .foregroundStyle(.black)
                                    .font(.regular(12))
                                    .padding(.bottom, 14)
                                
                                VStack {
                                    
                                    ModifyViewbutton(text: "소속 변경", action: {
                                        changeSchool = true
                                    }, color: .black)
                                    
                                    ModifyViewbutton(text: "개인 정보 이용 약관", action: {
                                        if let url = URL(string: "링크") {
                                            openURL(url)
                                        }
                                    }, color: .black)
                                    ModifyViewbutton(text: "로그아웃", action: {
                                        profileMV.delete()
                                        withAnimation {
                                            UserDefaults.standard.removeObject(forKey: "access")
                                        }
                                    }, color: .red)

                                    HStack {
                                        Spacer()
                                        Button {
                                            showAlert = true
                                        } label: {
                                            Text("회원탈퇴")
                                                .underline()
                                                .foregroundStyle(.red)
                                                .font(.regular(12))
                                        }
                                        .alert(isPresented: $showAlert) {
                                            Alert(
                                                title: Text("정말 회원탈퇴 하시겠습니까?"),
                                                primaryButton: .default(Text("취소"))
                                                {
                                                },
                                                secondaryButton: .destructive(Text("탈퇴")) {
                                                }
                                            )
                                        }
                                    }
                                    .padding(.vertical, 14)
                                    .padding(.trailing, 23)
                                }
                                
                                .padding()
                                Spacer()
                            }
                        }
                }
                .navigationDestination(isPresented: $changeName) {
                    ChangeNameView()
                }
                .navigationDestination(isPresented: $changeSchool) {
                    ChangingDepartmentView()
                }
                .ignoresSafeArea()
            }
            BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .black)
        }
    }
}
