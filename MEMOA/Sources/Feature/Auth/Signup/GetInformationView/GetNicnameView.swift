import SwiftUI

struct GetNicknameView: View {
    @ObservedObject var signUpVM: SignUpViewModel
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
            .hideKeyBoard()
            .edgesIgnoringSafeArea(.all)
            .enableNavigationSwipe()
            .addBackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .white)
            .navigationDestination(isPresented: $toGetSchoolView) {
                GetSchoolView(signUpVM: signUpVM)
            }
        }
    }
}
