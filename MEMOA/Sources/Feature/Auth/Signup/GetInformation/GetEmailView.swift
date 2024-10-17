import SwiftUI

struct GetEmailView: View {
    @StateObject var SignupMV: SignupModelView = .init()
    @Environment(\.dismiss) var dismiss
    @State private var GetpasswordViewboolean = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                AuthBackground()
                VStack {
                    AuthText(text: "회원가입")
                    HStack {
                        Image(icon: .textfiledimage)
                            .padding(.leading, 11)
                        TextField("이메일을 입력하세요", text: $SignupMV.email)
                            .tint(.maincolor)
                            .foregroundColor(.black)
                        
                        // 인증 -> 300초
                        if SignupMV.isTimerRunning {
                            Text("\(SignupMV.remainingTime)초")
                                .foregroundStyle(.gray) // 남은 시간을 표시하는 텍스트
                                .font(.medium(16))
                                .padding(.horizontal, 11)
                        } else {
                            Button(action: {
                                SignupMV.sendEmailToServer()
                                SignupMV.startCountdown() // 타이머 함수 호출
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
                    
                    CustomTextField(text: $SignupMV.code, placeholder: "인증번호 6자리를 입력하세요")
                    
                    Spacer()
                    TermsOfUseButton()
                    LongButton(text: "다음", color: .buttoncolor) {
                        GetpasswordViewboolean = true
                    }
                    .padding(.bottom, 60)
                }
            }
            .edgesIgnoringSafeArea(.all)
            BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .white)
            .navigationDestination(isPresented: $GetpasswordViewboolean) {
                GetpasswordView()
                    }
        }
    }
}

#Preview {
    GetEmailView()
}
