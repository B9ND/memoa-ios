import SwiftUI

struct GetpasswordView: View {
    @StateObject var SignupMV: SignupModelView = .init()
    @Environment(\.dismiss) var dismiss
    @State private var GetNicnameViewboolean = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                AuthBackground()
                VStack {
                    AuthText(text: "회원가입")
                    HStack {
                        Image(icon: .textfiledimage)
                            .padding(.leading, 11)
                        if SignupMV.isSecure {
                            SecureField("비밀번호를 입력하세요", text: $SignupMV.password)
                                .foregroundColor(.black)
                        } else {
                            TextField("비밀번호를 입력하세요", text: $SignupMV.password)
                                .foregroundColor(.black)
                                        }
                        Button(action: {
                            SignupMV.isSecure.toggle()})
                        {
                            Image(icon: SignupMV.isSecure ? .closeeye : .openeye)
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
                        GetNicnameViewboolean = true
                    }
                    .padding(.bottom, 60)
                }
            }
            .edgesIgnoringSafeArea(.all)
            BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .white)
            .navigationDestination(isPresented: $GetNicnameViewboolean) {
                GetNicnameView()
                    }
        }
    }
}

#Preview {
    GetpasswordView()
}
