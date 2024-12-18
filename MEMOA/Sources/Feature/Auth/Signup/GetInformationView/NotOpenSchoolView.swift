import SwiftUI

struct NotOpenSchoolView: View {
    @ObservedObject var signUpVM: SignUpViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                AuthBackground()
                VStack {
                    AuthText(text: "회원가입")
                    
                    Image(.sleep)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 136)
                    Image(.notopen)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 223)
                    
                    Spacer()
                    
                    TermsOfUseButton()
                    LongButton(text: "회원가입 후 기다리기", color: .buttoncolor) {
                    }
                    .padding(.bottom, 60)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .enableNavigationSwipe()
            .addBackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .white)
        }
    }
}
