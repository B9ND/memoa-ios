import SwiftUI

// TODO: 프로필 수정
struct ModifyView: View {
    @ObservedObject var profilMV: ProfilViewmodel = .init()
    
    @State private var showAlert = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    
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
                                        print("수정하기")
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
                                    ModifyViewbutton(text: "이름변경", action: {
                                        
                                    }, color: .black)
                                    
                                    ModifyViewbutton(text: "이메일 변경", action: {
                                        
                                    }, color: .black)
                                    
                                    ModifyViewbutton(text: "소속 변경", action: {
                                        openURL(URL(string: "https://www.naver.com")!)
                                        
                                    }, color: .black)
                                    
                                    ModifyViewbutton(text: "개인 정보 이용 약관", action: {
                                        
                                    }, color: .black)
                                    
                                    ModifyViewbutton(text: "회원탈퇴", action: {
                                        showAlert = true
                                    }, color: .red)
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
                                    ModifyViewbutton(text: "로그아웃", action: {
                                        
                                    }, color: .red)
                                }
                                
                                .padding()
                                Spacer()
                            }
                        }
                }
                .ignoresSafeArea()
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                            Text("뒤로가기")
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Bold", size: 16))
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    ModifyView()
}


