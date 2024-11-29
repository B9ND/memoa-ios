import SwiftUI

struct GetPasswordView: View {
    @ObservedObject var signUpVM: SignUpViewModel
    @State private var toGetNicknameView = false
    @State private var isPasswordValid = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                AuthBackground()
                VStack {
                    AuthText(text: "회원가입")
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Image(icon: .textfiledimage)
                                .padding(.leading, 11)
                            if signUpVM.isSecure {
                                SecureField("비밀번호를 입력하세요", text: $signUpVM.password)
                                    .foregroundColor(.black)
                                    .tint(.maincolor)
                                    .onChange(of: signUpVM.password) { newValue in
                                        isPasswordValid = signUpVM.isValidPassword(newValue)
                                    }
                            } else {
                                TextField("비밀번호를 입력하세요", text: $signUpVM.password)
                                    .foregroundColor(.black)
                                    .tint(.maincolor)
                                    .onChange(of: signUpVM.password) { newValue in
                                        isPasswordValid = signUpVM.isValidPassword(newValue)
                                    }
                            }
                            Button(action: {
                                signUpVM.isSecure.toggle()
                            }) {
                                Image(icon: signUpVM.isSecure ? .closeeye : .openeye)
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, 11)
                        }
                        .frame(width: 304, height: 46)
                        .background(.white)
                        .cornerRadius(8)
                        
                        if !signUpVM.password.isEmpty && !isPasswordValid {
                            Text("비밀번호는 5자 이상이어야 합니다")
                                .foregroundColor(.red)
                                .font(.caption)
                                .padding(.horizontal, 12)
                        }
                    }
                    Spacer()
                    TermsOfUseButton()
                    LongButton(text: "다음", color: .buttoncolor) {
                        toGetNicknameView = true
                    }
                    .disabled(!isPasswordValid)
                    .padding(.bottom, 60)
                }
            }
            .hideKeyBoard()
            .edgesIgnoringSafeArea(.all)
            .enableNavigationSwipe()
            .addBackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .white)
            .navigationDestination(isPresented: $toGetNicknameView) {
                GetNicknameView(signUpVM: signUpVM)
            }
        }
    }
}
