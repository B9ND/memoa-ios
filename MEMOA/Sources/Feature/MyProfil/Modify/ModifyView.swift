import SwiftUI

// TODO: 프로필 수정
struct ModifyView: View {
    @ObservedObject var profilMV: MyProfilViewModel = .init()
    
    @State private var showAlert = false
    @Environment(\.openURL) private var openURL
    @State private var changename = false
    @State private var changingdepartment = false
    
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
                        .cornerRadius(30, corners: .topLeft)
                        .cornerRadius(30, corners: .topRight)
                        .overlay {
                            VStack {
                                ZStack {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 100, height: 100)
                                        .padding(.top,-44)
                                        .overlay {
                                            Image(.profilimage)
                                                .padding(.top,-44)
                                        }
                                }
                                HStack {
                                    Text(profilMV.request.name)
                                        .font(.custom("Pretendard-Medium", size: 16))
                                    Button {
                                        changename.toggle()
                                    } label: {
                                        Image(.pencil)
                                    }
                                }
                                .padding(.bottom,4)
                                
                                .padding(.leading,20)
                                Text(profilMV.request.email)
                                    .foregroundStyle(.black)
                                    .font(.custom("Pretendard-Regular", size: 12))
                                    .padding(.bottom,14)
                                
                                VStack {
                                    
                                    ModifyViewbutton(text: "소속 변경", action: {
                                        changingdepartment.toggle()
                                    }, color: .black)
                                    
                                    ModifyViewbutton(text: "개인 정보 이용 약관", action: {
                                        
                                    }, color: .black)
                                    ModifyViewbutton(text: "로그아웃", action: {
                                        
                                    }, color: .red)

                                    HStack {
                                        Spacer()
                                        Button {
                                            showAlert = true
                                        } label: {
                                            Text("회원탈퇴")
                                                .underline()
                                                .foregroundStyle(.red)
                                                .font(.custom("Pretendard-Regular", size: 12))
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
                                    .padding(.vertical,14)
                                    .padding(.trailing,23)
                                }
                                
                                .padding()
                                Spacer()
                            }
                        }
                }
                .navigationDestination(isPresented: $changename, destination: {
                    ChangeNameView()
                })
                
                .navigationDestination(isPresented: $changingdepartment, destination: {
                    ChangingDepartmentView()
                })
                .ignoresSafeArea()
            }
            BackButton(text: "뒤로가기", systemImageName: "chevron.left")
        }
    }
}
#Preview {
    ModifyView()
}


