import SwiftUI

struct GetpasswordView: View {
    @StateObject var signUpMV: SignUpViewModel = .init()
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
                        if signUpMV.isSecure {
                            SecureField("비밀번호를 입력하세요", text: $signUpMV.password)
                                .foregroundColor(.black)
                                .tint(.maincolor)
                        } else {
                            TextField("비밀번호를 입력하세요", text: $signUpMV.password)
                                .foregroundColor(.black)
                                .tint(.maincolor)
                        }
                        Button(action: {
                            signUpMV.isSecure.toggle()})
                        {
                            Image(icon: signUpMV.isSecure ? .closeeye : .openeye)
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
                        toGetNicknameView = true
                    }
                    .padding(.bottom, 60)
                }
            }
            .edgesIgnoringSafeArea(.all)
            BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .white)
                .navigationDestination(isPresented: $toGetNicknameView) {
                    GetNicnameView()
                }
        }
    }
}

#Preview {
    GetpasswordView()
}
