import SwiftUI

struct GetNicnameView: View {
    @StateObject var signUpMV: SignUpViewModel = .init()
    @Environment(\.dismiss) var dismiss
    @State private var toGetSchoolView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                AuthBackground()
                VStack {
                    AuthText(text: "회원가입")
                    CustomTextField(text: $signUpMV.nickname, placeholder: "닉네임을 입력하세요")
                    Spacer()
                    TermsOfUseButton()
                    LongButton(text: "다음", color: .buttoncolor) {
                        toGetSchoolView = true
                    }
                    .padding(.bottom, 60)
                }
            }
            .edgesIgnoringSafeArea(.all)
            BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .white)
                .navigationDestination(isPresented: $toGetSchoolView) {
                    GetSchoolView()
                }
        }
    }
}

#Preview {
    GetNicnameView()
}
