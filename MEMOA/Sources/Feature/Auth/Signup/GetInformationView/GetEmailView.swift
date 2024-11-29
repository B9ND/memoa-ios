import SwiftUI

struct GetEmailView: View {
    @StateObject private var signUpVM = SignUpViewModel()
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var isCodeValid = false
    @State private var isEmailValid = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                AuthBackground()
                VStack {
                    AuthText(text: "회원가입")
                    HStack {
                        Image(icon: .textfiledimage)
                            .padding(.leading, 11)
                        TextField("이메일을 입력하세요", text: $signUpVM.email)
                            .foregroundColor(.black)
                            .tint(.maincolor)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                            .onChange(of: signUpVM.email) { newValue in
                                isEmailValid = signUpVM.isValidEmail(newValue)
                            }
                        
                        if signUpVM.isTimerRunning {
                            Text("\(signUpVM.remainingTime)초")
                                .foregroundStyle(.gray)
                                .font(.medium(16))
                                .padding(.horizontal, 11)
                        } else {
                            Button {
                                Task {
                                    switch await signUpVM.sendEmailToServer() {
                                    case .success(let message):
                                        alertTitle = "알림"
                                        alertMessage = message
                                        showAlert = true
                                        signUpVM.startCountdown()
                                    case .failure(let error):
                                        alertTitle = "오류"
                                        alertMessage = error.localizedDescription
                                        showAlert = true
                                    }
                                }
                            } label: {
                                Text("인증")
                                    .foregroundStyle(isEmailValid ? .maincolor : .gray)
                                    .font(.medium(16))
                                    .padding(.horizontal, 11)
                            }
                            .disabled(!isEmailValid)
                        }
                    }
                    .frame(width: 304, height: 46)
                    .background(.white)
                    .cornerRadius(8)
                    .padding(.bottom, 2)
                    
                    if !signUpVM.email.isEmpty && !isEmailValid {
                        Text("유효한 이메일 주소를 입력해주세요")
                            .foregroundColor(.white)
                            .font(.medium(10))
                    }
                    
                    CustomTextField(text: $signUpVM.code, placeholder: "인증번호 6자리를 입력하세요")
                    
                    Spacer()
                    TermsOfUseButton()
                    
                    LongButton(text: "다음", color: .buttoncolor) {
                        Task {
                            switch await signUpVM.verifyCode() {
                            case .success(_):
                                alertTitle = "성공"
                                alertMessage = "인증이 완료되었습니다"
                                showAlert = true
                                isCodeValid = true
                            case .failure(let error):
                                alertTitle = "오류"
                                alertMessage = error.localizedDescription
                                showAlert = true
                            }
                        }
                    }
                    .disabled(signUpVM.code.isEmpty || !isEmailValid)
                    .padding(.bottom, 60)
                }
            }
            .hideKeyBoard()
            .edgesIgnoringSafeArea(.all)
            .alert(alertTitle, isPresented: $showAlert) {
                Button("확인", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
            .navigationDestination(isPresented: $isCodeValid) {
                GetPasswordView(signUpVM: signUpVM)
            }
            .enableNavigationSwipe()
            .addBackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .white)
        }
    }
}
