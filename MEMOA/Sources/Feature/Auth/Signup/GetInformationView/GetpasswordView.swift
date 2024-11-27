import SwiftUI

struct GetpasswordView: View {
    @StateObject var signUpVM = SignUpViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var toGetNicknameView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                AuthBackground()
                VStack {
                    AuthText(text: "회원가입")
                    HStack {
                        Image(icon: .textfiledimage)
                            .padding(.leading, 11)
                        if signUpVM.isSecure {
                            SecureField("비밀번호를 입력하세요", text: $signUpVM.password)
                                .foregroundColor(.black)
                                .tint(.maincolor)
                        } else {
                            TextField("비밀번호를 입력하세요", text: $signUpVM.password)
                                .foregroundColor(.black)
                                .tint(.maincolor)
                        }
                        Button(action: {
                            signUpVM.isSecure.toggle()})
                        {
                            Image(icon: signUpVM.isSecure ? .closeeye : .openeye)
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 11)
                    }
                    .frame(width: 304, height: 46)
                    .background(.white)
                    .cornerRadius(8)
                    Spacer()
                    TermsOfUseButton()
                    LongButton(text: "다음", color: .buttoncolor) {
                        print(signUpVM.email)
                        toGetNicknameView = true
                    }
                    .padding(.bottom, 60)
                }
            }
            .onAppear(perform : UIApplication.shared.hideKeyboard)
            .edgesIgnoringSafeArea(.all)
                .addBackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .white)
                .navigationDestination(isPresented: $toGetNicknameView) {
                    GetNicnameView(signUpVM: signUpVM)
                }
        }
    }
}
