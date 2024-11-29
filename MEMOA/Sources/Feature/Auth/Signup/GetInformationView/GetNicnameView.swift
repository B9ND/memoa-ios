import SwiftUI

struct GetNicknameView: View {
    @ObservedObject var signUpVM: SignUpViewModel
    @Environment(\.dismiss) var dismiss
    @State private var toGetSchoolView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                AuthBackground()
                VStack {
                    AuthText(text: "회원가입")
                    CustomTextField(text: $signUpVM.nickname, placeholder: "닉네임을 입력하세요")
                    Spacer()
                    TermsOfUseButton()
                    LongButton(text: "다음", color: .buttoncolor) {
                        toGetSchoolView = true
                    }
                    .disabled(signUpVM.nickname.isEmpty)
                    .padding(.bottom, 60)
                }
            }
            .onAppear(perform: UIApplication.shared.hideKeyboard)
            .edgesIgnoringSafeArea(.all)
            .addBackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .white)
            .navigationDestination(isPresented: $toGetSchoolView) {
                GetSchoolView(signUpVM: signUpVM)
            }
        }
    }
}
