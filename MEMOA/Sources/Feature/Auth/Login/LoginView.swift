import SwiftUI

struct LoginView: View {
    @ObservedObject var LoginVM: LoginViewModel = .init()
    @Environment(\.dismiss) var dismiss
    @State private var isLoginSuccess = false
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            AuthBackground()
            
            VStack {
                AuthText(text: "로그인")
                
                CustomTextField(text: $LoginVM.email, placeholder: "이메일을 입력하세요")
                    .padding(.bottom, 2)
                
                HStack {
                    Image(icon: .textfiledimage)
                        .padding(.leading, 11)
                    
                    if LoginVM.isSecure {
                        SecureField("비밀번호를 입력하세요", text: $LoginVM.password)
                            .foregroundColor(.black)
                            .tint(.maincolor)
                    } else {
                        TextField("비밀번호를 입력하세요", text: $LoginVM.password)
                            .foregroundColor(.black)
                            .tint(.maincolor)
                    }
                    
                    Button(action: {
                        LoginVM.isSecure.toggle()
                    }) {
                        Image(icon: LoginVM.isSecure ? .closeeye : .openeye)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 11)
                }
                .frame(width: 304, height: 46)
                .background(.white)
                .cornerRadius(8)
                
                Spacer()
                
                
                LongButton(text: "로그인", color: .buttoncolor) {
                    LoginVM.login { success in
                        if success {
                            isLoginSuccess = true
                        } else {
                            print(LoginVM.loginerrorMessage ?? "로그인 실패")
                            showAlert = true
                        }
                    }
                }
                .padding(.bottom, 60)
                .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("로그인 실패"),
                                message: Text("다시 시도해 주세요."),
                                dismissButton: .default(Text("확인"))
                            )
                        }
            }
        }
        .onAppear(perform : UIApplication.shared.hideKeyboard)
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $isLoginSuccess) {
            MainView()
        }
        BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .white)
    }
}
#Preview {
    LoginView()
}
