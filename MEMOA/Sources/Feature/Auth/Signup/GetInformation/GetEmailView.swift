import SwiftUI

struct GetEmailView: View {
    @StateObject var signUpMV: SignUpViewModel = .init()
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
                        TextField("이메일을 입력하세요", text: $signUpMV.email)
                            .foregroundColor(.black)
                        
                        if signUpMV.isTimerRunning {
                            Text("\(signUpMV.remainingTime)초")
                                .foregroundStyle(.gray)
                                .font(.medium(16))
                                .padding(.horizontal, 11)
                        } else {
                            Button(action: {
                                signUpMV.sendEmailToServer()
                                signUpMV.startCountdown()
                            }, label: {
                                Text("인증")
                                    .foregroundStyle(.maincolor)
                                    .font(.medium(16))
                                    .padding(.horizontal, 11)
                            })
                        }
                    }
                    .frame(width: 304, height: 46)
                    .background(.white)
                    .cornerRadius(8)
                    .padding(.bottom, 2)
                    
                    CustomTextField(text: $signUpMV.code, placeholder: "인증번호 6자리를 입력하세요")
                    
                    Spacer()
                    TermsOfUseButton()
                    
                    LongButton(text: "다음", color: .buttoncolor) {
                        Task {
                            let isCodeValidResponse = await signUpMV.verifyCode()
                            if isCodeValidResponse {
                                isCodeValid = true
                            } else {
                                alertMessage = "인증번호가 틀렸습니다."
                                showAlert = true
                            }
                        }
                    }
                    .padding(.bottom, 60)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("오류"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
            }
            .navigationDestination(isPresented: $isCodeValid) {
                GetNicnameView()
            }
            BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .white)
        }
    }
}

#Preview {
    GetEmailView()
}
