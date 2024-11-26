import SwiftUI

struct GetEmailView: View {
    @StateObject var signUpVM = SignUpViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isCodeValid = false
    
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
                        
                        if signUpVM.isTimerRunning {
                            Text("\(signUpVM.remainingTime)초")
                                .foregroundStyle(.gray)
                                .font(.medium(16))
                                .padding(.horizontal, 11)
                        } else {
                            Button {
                                // 이메일 인증 버튼도 비동기 처리를 위해 Task로 감싸기
                                Task {
                                    if await signUpVM.sendEmailToServer() {
                                        signUpVM.startCountdown()
                                    } else {
                                        alertMessage = "이메일 전송에 실패했습니다."
                                        showAlert = true
                                    }
                                }
                            } label: {
                                Text("인증")
                                    .foregroundStyle(.maincolor)
                                    .font(.medium(16))
                                    .padding(.horizontal, 11)
                            }
                        }
                    }
                    .frame(width: 304, height: 46)
                    .background(.white)
                    .cornerRadius(8)
                    .padding(.bottom, 2)
                    
                    CustomTextField(text: $signUpVM.code, placeholder: "인증번호 6자리를 입력하세요")
                    
                    Spacer()
                    TermsOfUseButton()
                    
                    LongButton(text: "다음", color: .buttoncolor) {
                        // 비동기 작업을 Task로 감싸서 처리
                        Task {
                            let isCodeValidResponse = await signUpVM.verifyCode()
                            // UI 업데이트는 메인 스레드에서 처리
                            await MainActor.run {
                                if isCodeValidResponse {
                                    isCodeValid = true
                                } else {
                                    alertMessage = "인증번호가 틀렸습니다."
                                    showAlert = true
                                }
                            }
                        }
                    }
                    .padding(.bottom, 60)
                }
            }
            .onAppear(perform: UIApplication.shared.hideKeyboard)
            .edgesIgnoringSafeArea(.all)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("오류"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
            }
            .navigationDestination(isPresented: $isCodeValid) {
                GetpasswordView(signUpVM: signUpVM)
            }
            .addBackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .white)
        }
    }
}
